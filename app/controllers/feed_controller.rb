class FeedController < ApplicationController

	def index
    respond_to do |format|
      format.html do 
        update_tweets_and_grams_with_hashtag ENV["HASHTAG"]

        get_all_posts_in_desc_order

        render "index"
      end

      format.json do 
        get_all_posts_in_desc_order
        render :json => @posts
      end
    end
  end

  private

    def get_all_posts_in_desc_order
      @posts = (Tweet.all + Gram.all).sort_by { |post| post.created_at }
      @posts.reverse!
    end

    def update_tweets_and_grams_with_hashtag(hashtag)
      TweetService.get_tweets_by_hashtag(hashtag)
      InstagramService.get_grams_by_hashtag(hashtag)
    end
end