class FeedController < ApplicationController

  include PostHelper
  include YoutubeVideoHelper
  include VineVideoHelper
  include InstagramVideoHelper
  include ActionView::Helpers::UrlHelper

  def index
    respond_to do |format|
      format.html do
        @posts = Post.limited_sorted_posts(100, ENV["HASHTAG"])
        render "index"
      end
      format.json do
        @posts = Post.get_new_posts(ENV["HASHTAG"])
        render_json_posts @posts
      end
    end
  end

  def get_next_page
    @posts = Post.next_posts(params[:last_post_id], 100)
    render_json_posts @posts
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

end

