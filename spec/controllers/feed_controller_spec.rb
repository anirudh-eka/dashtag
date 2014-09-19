require 'spec_helper'

describe FeedController do
  describe 'GET #index' do
    let(:list_of_posts_in_desc_order) { (Tweet.all + Gram.all).sort_by{|post| post.created_at}.reverse }

    context "with HTML request" do 
      it 'should tell twitter service to get tweets from twitter to update db' do
        expect(TweetService.instance).to receive(:get_tweets_by_hashtag).with(ENV["HASHTAG"])
        get :index, :format => :html
      end

      it 'should tell instagram service to get grams from instagram to update db' do
        expect(InstagramService.instance).to receive(:get_grams_by_hashtag).with(ENV["HASHTAG"])
        get :index, :format => :html
      end

      it "should return all posts in db" do 
        get :index, :format => :html
        expect(assigns(:posts)).to eq(list_of_posts_in_desc_order)
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

      it "should return all posts in the db" do
        get :index, :format => :json
        expect(assigns(:posts)).to eq(list_of_posts_in_desc_order)
      end
    end
  end
end