require 'spec_helper'

describe Xing::User do

  before do
    client.stub(:consumer).and_return(consumer)
    client.authorize_from_access('atoken', 'asecret')
  end

  let(:client){Xing::Client.new('token', 'secret')}
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