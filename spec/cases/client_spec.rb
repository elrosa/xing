require 'spec_helper'

describe Xing::Client do
  before do
    client.stub(:consumer).and_return(consumer)
  end

  let(:client) { Xing::Client.new(:consumer_key => "consumer_key", :consumer_secret => "consumer_secret", :oauth_token => "oauth_token", :oauth_token_secret => "oauth_token_secret") }
  let(:consumer) { OAuth::Consumer.new('token', 'secret', {:site => 'https://api.xing.com'}) }

  describe "User's network feed" do

    it "client should get users feed" do
      stub_http_request(:get, /https:\/\/api.xing.com\/v1\/users\/me\/network_feed.*/).
          to_return(:body => "{}")
      posts = client.network_feed
      posts.length.should == 0
      posts.should be_an_instance_of(Array)
    end

    it "returned array should contain posts" do
      stub_http_request(:get, /https:\/\/api.xing.com\/v1\/users\/me\/network_feed.*/).
          to_return(:body => fixture("network_feed.json"))
      posts = client.network_feed
      posts.length.should == 9
      posts.first.should be_an_instance_of(Xing::Post)
    end
  end

  describe "#contacts" do
    before do
      stub_request(:get, "https://api.xing.com/v1/users/me/contacts?limit=3&offset=0").
          to_return(:status => 200, :body => fixture("contacts_page_1.json"), :headers => {})
      stub_request(:get, "https://api.xing.com/v1/users/me/contacts?limit=3&offset=3").
          to_return(:status => 200, :body => fixture("contacts_page_2.json"), :headers => {})
    end

    subject { client.contacts(limit: 3) }

    it { should be_a_kind_of Hash }
    its(['total']) { should be 5 }

    it 'should return all users' do
      subject['users'].size.should == 5
    end
  end
end