class FeedController < ApplicationController

  include TwitterHelper
  include YoutubeVideoHelper
  include ActionView::Helpers::UrlHelper

  @number_of_posts_in_page = 50
  def index
    respond_to do |format|
      format.html do
        @posts = []#Post.all_sorted_by_time_of_post(ENV["HASHTAG"]).page(params[:page]).per(50)

        render "index"
      end

      format.json do
        @posts = Post.get_new_posts(ENV["HASHTAG"])
        if @posts
          @posts.each do |post|
            post.text = CGI.unescapeHTML(post.text)
            if post.source == 'twitter'
             post.text = add_tweet_links post[:text], post[:urls]
            end
          end
          render json: @posts
        else
          render json: @posts, status: :not_modified
        end
      end
    end
  end

  def get_next_page
    requested_page = params[:last_page_requested].to_i+1

    @posts = Post.all_sorted_by_time_of_post(ENV["HASHTAG"]).page(requested_page).per(@number_of_posts_in_page)
    render json: @posts
  end
end