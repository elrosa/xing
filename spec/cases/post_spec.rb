require 'spec_helper'

describe Xing::Post do

  before do
    client.stub(:consumer).and_return(consumer)
    @fixture = MultiJson.load(fixture "post.json")
    @post = Xing::Post.new(@fixture)
  end

  let(:client) {Xing::Client.new(:consumer_key => "consumer_key", :consumer_secret => "consumer_secret", :oauth_token => "oauth_token", :oauth_token_secret => "oauth_token_secret")}
  let(:consumer){OAuth::Consumer.new('token', 'secret', {:site => 'https://api.xing.com'})}

  #before :each do
  #end

  it "should contain correct posting date" do
    @post.posted_at.should == Time.parse(@fixture["created_at"]).utc
  end

  it "should contain user information" do
    @post.user.should be_instance_of(Xing::User)
    @post.user.name.should == "Test User"
    @post.user.id.should == "123456789"
  end

  it "should have information about possibility of adding comment" do
    @post.commentable.should_not == nil
    @post.commentable.should == true
  end

  it "should have information about possibility of adding like" do
    @post.likable.should_not == nil
    @post.likable.should == true
  end

  it "should have information if current user liked it already" do
    @post.liked.should_not == nil
    @post.liked.should == false
  end

  it "should have information about possibility of sharing" do
    @post.sharable.should_not == nil
    @post.sharable.should == false
  end

  it "should have information about possibility of deleting" do
    @post.deletable.should_not == nil
    @post.deletable.should == false
  end

  it "should have activity list" do
    @post.activities.should be_instance_of(Array)
  end

  it "should have comment list" do
    @post.comments.should be_instance_of(Array)
    @post.comments.length.should == 1
    @post.comments.first.should be_instance_of(Xing::Comment)
  end

  it "should have like count" do
    @post.like_count.should be_instance_of(Fixnum)
    @post.like_count.should == 0
  end

end