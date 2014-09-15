class FeedController < ApplicationController

	def index
    respond_to do |format|
      format.html do 
        TweetService.get_tweets_by_hashtag "NAAwayDay"
        @tweets = Tweet.order(created_at: :desc)
        render "index"
      end

      format.json do 
        p "json" * 40
        p Tweet.order(created_at: :desc).first
        @tweets = Tweet.order(created_at: :desc)
        render :json => @tweets
      end
    end

  end
end