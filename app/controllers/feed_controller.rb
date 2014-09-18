class FeedController < ApplicationController

	def index
    respond_to do |format|
      format.html do 
        update_tweets_and_grams_with_hashtag ENV["HASHTAG"]

        @posts = Post.all

        render "index"
      end

      format.json do 
        @posts = Post.all
        render :json => @posts
      end
    end
  end

  private
  
  def update_tweets_and_grams_with_hashtag(hashtag)
    TweetService.get_tweets_by_hashtag(hashtag)
    InstagramService.get_grams_by_hashtag(hashtag)
  end
end