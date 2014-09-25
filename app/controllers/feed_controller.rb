class FeedController < ApplicationController

	def index
    respond_to do |format|
      format.html do 
        update_tweets_and_grams_with_hashtag ENV["HASHTAG"]

        @posts = Post.order(created_at: :desc).page(params[:page]).per(50)

        render "index"
      end

      format.json do
        old_last_update = APIService.instance.last_update
        update_tweets_and_grams_with_hashtag ENV["HASHTAG"]
        new_last_update = APIService.instance.last_update

        if new_last_update > old_last_update
          @posts = Post.order(time_of_post: :desc).select{|post| post.created_at > new_last_update}
          render json: @posts
        else
          render json: @posts, status: :not_modified
        end
      end
    end
  end

  def get_next_page
    @posts = Post.order(created_at: :desc).page(params[:last_page_requested].to_i+1).per(50)
    render json: @posts
  end

  private
  
  def update_tweets_and_grams_with_hashtag(hashtag)
    APIService.instance.get_posts(hashtag)
  end
end