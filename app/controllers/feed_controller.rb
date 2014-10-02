class FeedController < ApplicationController

  include PostHelper
  include ActionView::Helpers::UrlHelper

  def index
    respond_to do |format|
      format.html do
        @posts = Post.sorted_posts(ENV["HASHTAG"], 100)
        render "index"
      end

      format.json do
        @posts = Post.get_new_posts(ENV["HASHTAG"])
        if @posts
          @posts.each do |post|
             post.text = add_post_links post
          end
          render json: @posts
        else
          render json: @posts, status: :not_modified
        end
      end
    end
  end

  def get_next_page
    @posts = Post.next_posts(params[:last_post_id], 100)
    @posts.each do |post|
      post.text = add_post_links post
    end
    @posts.empty? ? (render json: @posts, status: :not_modified) : (render json: @posts)
  end
end

