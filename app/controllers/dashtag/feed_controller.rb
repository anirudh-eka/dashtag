require_dependency "dashtag/application_controller"

module Dashtag
  class FeedController < ApplicationController

    include PostHelper
    include ActionView::Helpers::UrlHelper

    def index
      respond_to do |format|
        format.html do
          @posts = Post.limited_sorted_posts(100)
          render "index"
        end
        format.json do
          @posts = Post.get_new_posts(convert_to_seconds(params[:last_update_time]))
          render_json_posts @posts
        end
      end
    end

    def get_next_page
      @posts = Post.next_posts(Post.find(params[:last_post_id]), 100)
      render_json_posts @posts
    end

    def get_new_posts
      puts "*" * 80
      p "hit route"
      @posts = Post.get_new_posts(convert_to_seconds(params[:last_update_time]))
      render partial: "posts"
    end

    private

    def render_json_posts(posts)
      if posts.nil? || posts.empty?
        render json: posts, status: :not_modified
      else
        posts.each { |post| post.text = add_post_links post }
        render json: posts
      end
    end

    def convert_to_seconds(time)
      time.to_f/1000
    end
  end
end
