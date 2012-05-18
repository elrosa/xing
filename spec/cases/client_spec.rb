require 'spec_helper'

describe Xing::Client do
  before do
    client.stub(:consumer).and_return(consumer)
  end

  let(:client) {Xing::Client.new(:consumer_key => "consumer_key", :consumer_secret => "consumer_secret", :oauth_token => "oauth_token", :oauth_token_secret => "oauth_token_secret")}
  let(:consumer){OAuth::Consumer.new('token', 'secret', {:site => 'https://api.xing.com'})}

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

end