class FeedController < ApplicationController

	def index
    respond_to do |format|
      format.html do 
        TweetService.get_tweets_by_hashtag(ENV["HASHTAG"])
        InstagramService.get_grams_by_hashtag(ENV["HASHTAG"])
        @tweets = Tweet.order(created_at: :desc)
        @grams = Gram.order(created_at: :desc)

        @posts = (@tweets + @grams).sort_by { |post| post.created_at }
        @posts.reverse!
        render "index"
      end

      format.json do 
        @tweets = Tweet.order(created_at: :desc)
        @grams = Gram.order(created_at: :desc)
        @posts = (@tweets + @grams).sort_by { |post| post.created_at }
        @posts.reverse!
        render :json => @posts
      end
    end

  end
end