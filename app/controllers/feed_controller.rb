require 'pry'
class FeedController < ApplicationController

	def index
    respond_to do |format|
      format.html do 
        update_tweets_and_grams_with_hashtag ENV["HASHTAG"]

        @posts = Post.order(created_at: :desc)

        render "index"
      end

      format.json do
        last_update = TweetService.instance.last_update
        update_tweets_and_grams_with_hashtag ENV["HASHTAG"]
        @posts = Post.order(created_at: :desc)
        render :json => @posts
      end
    end
  end

  private
  
  def update_tweets_and_grams_with_hashtag(hashtag)
    TweetService.instance.get_tweets_by_hashtag(hashtag)
    InstagramService.instance.get_grams_by_hashtag(hashtag)
  end
end