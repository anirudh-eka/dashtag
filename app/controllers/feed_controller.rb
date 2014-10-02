class FeedController < ApplicationController

  include PostHelper
  include YoutubeVideoHelper
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
          add_links_to_posts(@posts)
          render json: @posts
        else
          render json: @posts, status: :not_modified
        end
      end
    end
  end

  def get_next_page
    @posts = Post.next_posts(params[:last_post_id], 100)
    add_links_to_posts(@posts)
    @posts.empty? ? (render json: @posts, status: :not_modified) : (render json: @posts)
  end

  private

  def add_links_to_posts(posts)
    posts.each do |post|
      post.text = add_post_links post
    end
  end
end

