require 'pry'
class FeedController < ApplicationController

  def index
    respond_to do |format|
      format.html do
        @posts = Post.newest_fifty_posts(ENV["HASHTAG"])
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
    @posts = Post.next_fifty_posts(params[:last_post_id])
    render json: @posts
  end
end

