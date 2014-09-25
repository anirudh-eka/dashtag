class FeedController < ApplicationController

	def index
    respond_to do |format|
      format.html do 
        update_tweets_and_grams_with_hashtag ENV["HASHTAG"]

        @posts = sort_by_date.page(params[:page]).per(50)

        render "index"
      end

      format.json do
        if @posts = get_new_posts(ENV["HASHTAG"])
          
          render json: @posts
        else
          render json: @posts, status: :not_modified
        end
      end
    end
  end

  def get_next_page
    number_of_posts_in_page = 50
    requested_page = params[:last_page_requested].to_i+1

    @posts = sort_by_date.page(requested_page).per(number_of_posts_in_page)
    render json: @posts
  end

  ######### service stuff
  def pull_new_posts(hashtag)
    @old_last_update = APIService.instance.last_update
    APIService.instance.get_posts(hashtag)
    @new_last_update = APIService.instance.last_update
  end


  def did_service_update?
    @new_last_update > @old_last_update
  end

  def new_last_update
    @new_last_update
  end

  #####Model stuff

  def get_new_posts(hashtag)
    pull_new_posts(hashtag)
    if did_service_update?
      Post.order(time_of_post: :desc).select { |post| is_post_from_last_pull?(post) }
    else
      nil
    end
  end

  def is_post_from_last_pull?(post)
    post.created_at > new_last_update
  end



#######


  def sort_by_date
    Post.order(time_of_post: :desc)
  end

  private
  
  def update_tweets_and_grams_with_hashtag(hashtag)
    APIService.instance.get_posts(hashtag)
  end
end