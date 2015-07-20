require_dependency "dashtag/application_controller"

module Dashtag
  class FeedController < ApplicationController

    include PostHelper
    include ActionView::Helpers::UrlHelper

    def index
      @settings = Settings.load_settings
      respond_to do |format|
        format.html do
          @posts = Post.limited_sorted_posts(100)
          render "index"
        end
      end
    end

    def get_older_posts
      @posts = Post.next_posts(Post.find(params[:last_post_id]), 100)
      render_posts_with_status(@posts)
    end

    def get_new_posts
      @posts = Post.get_new_posts(convert_to_seconds(params[:last_update_time]))
      render_posts_with_status(@posts)
      # render partial: "posts"
    end

    private

    def render_posts_with_status(posts)
      if posts.nil? || posts.empty?
        render partial: "posts", status: :not_modified
      else
        # posts.each { |post| post.text = add_post_links post }
        render partial: "posts"
      end
    end

    def convert_to_seconds(time)
      time.to_f/1000
    end
  end
end
