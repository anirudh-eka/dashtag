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

	def ==(post)
    text == post.text &&
    screen_name == post.screen_name &&
    time_of_post == post.time_of_post &&
    media_url == post.media_url &&
    source == post.source
  end

  def self.tweets
    Post.where(source: "twitter")
  end

  def self.grams
    Post.where(source: "instagram")
  end
end