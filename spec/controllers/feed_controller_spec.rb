require 'spec_helper'

describe FeedController do
  describe 'GET #index' do
    context "with HTML request" do 
      it 'should tell twitter service to get tweets from twitter to update db' do
        expect(TweetService).to receive(:get_tweets_by_hashtag).with(ENV["HASHTAG"])
        get :index, :format => :html
      end

      it 'should tell instagram service to get grams from instagram to update db' do
        expect(InstagramService).to receive(:get_grams_by_hashtag).with(ENV["HASHTAG"])
        get :index, :format => :html
      end

      it "should return all tweets in db" do 
        get :index, :format => :html
        expect(assigns(:tweets)).to eq(Tweet.order(created_at: :desc))
      end
    end
    context "with JSON request" do 
      it "should not tell service to get tweets from twitter to update db" do
        #this updating of db will be done by a scheduled chron job
        #we are doing this so that multiple user json requests do not 
        #make the service hit the Twitter API beyond the rate limit Twitter enforces
        expect(TweetService).to_not receive(:get_tweets_by_hashtag)
        get :index, :format => :json
      end

      it "should return all tweets in the db" do
        get :index, :format => :json
        expect(assigns(:tweets)).to eq(Tweet.order(created_at: :desc))
      end
    end
  end
end