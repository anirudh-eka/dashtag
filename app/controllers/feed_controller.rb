class FeedController < ApplicationController

	def index
    respond_to do |format|
      format.html do 
        TweetService.get_tweets_by_hashtag(ENV["HASHTAG"])
        @tweets = Tweet.order(created_at: :desc)
        render "index"
      end

      format.json do 
        @tweets = Tweet.order(created_at: :desc)
        render :json => @tweets
      end
    end

  end
end