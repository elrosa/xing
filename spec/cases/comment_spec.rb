require 'spec_helper'

describe Xing::Comment do

  before do
    client.stub(:consumer).and_return(consumer)
    client.authorize_from_access('atoken', 'asecret')
  end

  let(:client){Xing::Client.new('token', 'secret')}
  let(:consumer){OAuth::Consumer.new('token', 'secret', {:site => 'https://api.xing.com'})}

  before :each do
    @fixture = MultiJson.load(fixture "post.json")
    @post = Xing::Post.new(@fixture)
    @comment = @post.comments.first
  end

  it "should contain correct posting date" do
    @comment.posted_at.should == Time.parse(@fixture["comments"]["latest_comments"].first["created_at"]).utc
  end

  it "should contain user information" do
    @comment.user.should be_instance_of(Xing::User)
    @comment.user.name.should == "Test User"
    @comment.user.id.should == "123456789"
  end

end