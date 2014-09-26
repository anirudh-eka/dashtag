require 'pry'
class FeedController < ApplicationController

  @number_of_posts_in_page = 50
  def index
    respond_to do |format|
      format.html do
        @posts = Post.all_sorted_by_time_of_post(ENV["HASHTAG"]).page(params[:page]).per(50)

        render "index"
      end

      format.json do
        @posts = Post.get_new_posts(ENV["HASHTAG"])
        if @posts
          render json: @posts
        else
          render json: @posts, status: :not_modified
        end
      end
    end
  end

  def get_next_page
    requested_page = params[:last_page_requested].to_i+1

    @posts = sort_by_date.page(requested_page).per(@number_of_posts_in_page)
    render json: @posts
  end

  private
  
  def update_tweets_and_grams_with_hashtag(hashtag)
    APIService.instance.get_posts(hashtag)
  end
end