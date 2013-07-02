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
      stub_request(:get, "https://api.xing.com/v1/users/me/contacts?limit=3&offset=3").
          to_return(:status => 200, :body => fixture("contacts_page_1.json"), :headers => {})
      stub_request(:get, "https://api.xing.com/v1/users/me/contacts?limit=3&offset=0").
          to_return(:status => 200, :body => fixture("contacts_page_2.json"), :headers => {})
    end

    subject { client.contacts(limit: 3) }

    it { should be_a_kind_of Hash }
    its(['total']) { should be 5 }

    it 'should return all users' do
      subject['users'].size.should == 5
    end
  end

  describe '#create_conversation' do
    let(:conversation_hash) { {content: 'msg', recipient_ids: [1, 2], subject: 'subject with special chars!'} }
    subject { client.create_conversation conversation_hash }

    before do
      stub_request(:post, "https://api.xing.com/v1/users/me/conversations?content=msg&recipient_ids=1,2&subject=subject%20with%20special%20chars!").
          to_return(:status => 200, :body => fixture("create_conversation_result.json"), :headers => {})
    end

    it { should be_a_kind_of Xing::Mash }
    its(:read_only) { should be false }
    its(:id) { should == "492404154_a73d39" }
    its(:latest_messages) { should be_a_kind_of Array }
    its('latest_messages.count') { should be 1 }
    its('latest_messages.first') { should be_a_kind_of Xing::Mash }
    its('participants.count') { should be 2 }
    its('participants.first') { should be_a_kind_of Xing::Mash }
  end

  describe '#create_status_message' do
    subject { client.create_status_message('message with special chars!') }

    before do
      stub_request(:post, "https://api.xing.com/v1/users/me/status_message?message=message%20with%20special%20chars!").
        to_return(:status => 201, :body => 'Status update has been posted', :headers => {})
    end

    it { should be_a_kind_of Xing::Mash }
    its(:code) { should be 201 }
    its(:body) { should == 'Status update has been posted' }
  end
end
