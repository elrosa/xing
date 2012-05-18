require 'spec_helper'

describe Xing::User do

  before do
     client.stub(:consumer).and_return(consumer)
   end

   let(:client) {Xing::Client.new(:consumer_key => "consumer_key", :consumer_secret => "consumer_secret", :oauth_token => "oauth_token", :oauth_token_secret => "oauth_token_secret")}
   let(:consumer){OAuth::Consumer.new('token', 'secret', {:site => 'https://api.xing.com'})}


  before :each do
    @fixture = MultiJson.load(fixture "post.json")
    @post = Xing::Post.new(@fixture)
    @user = @post.user
  end

  it "should contain correct name" do
    @user.name.should == "Test User"
  end


end