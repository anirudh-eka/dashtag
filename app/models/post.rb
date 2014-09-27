class Post < ActiveRecord::Base
	validates_presence_of :screen_name, :time_of_post,
	 					:profile_image_url, :source

	validates_uniqueness_of :screen_name, scope: :time_of_post

  def as_json(options={})
    super.as_json().merge({formatted_time_of_post: formatted_time_of_post})
  end

  def formatted_time_of_post
    time_of_post.strftime("%a %b %d %l:%M %p")
  end

  def self.get_new_posts(hashtag)
    if APIService.instance.pull_posts(hashtag)
      order(time_of_post: :desc).select { |post| is_post_from_last_pull?(post) }
    else
      nil
    end
  end

  def ==(post)
    text == post.text &&
    screen_name == post.screen_name &&
    time_of_post == post.time_of_post &&
    media_url == post.media_url &&
    source == post.source
  end

  def self.all(hashtag=false)
    APIService.instance.pull_posts(hashtag) if hashtag
    super()
  end

  def self.tweets
    where(source: "twitter")
  end

  def self.grams
    where(source: "instagram")
  end

  def self.all_sorted_by_time_of_post(hashtag=false)
    all(hashtag).order(time_of_post: :desc)
  end

private

  def self.is_post_from_last_pull?(post)
    post.created_at > APIService.instance.last_update
  end
end