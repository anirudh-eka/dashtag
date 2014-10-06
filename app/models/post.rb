class Post < ActiveRecord::Base
	validates_presence_of :screen_name, :time_of_post, :profile_image_url, :source, :post_id

	validates_uniqueness_of :screen_name, scope: :time_of_post

  def as_json(options={})
    super.as_json().merge({formatted_time_of_post: time_of_post})
  end

  def self.get_new_posts(hashtag)
    order(time_of_post: :desc).select { |post| is_post_from_last_pull?(post) } if APIService.instance.pull_posts(hashtag)
  end

  def ==(post)
    text == post.text &&
    screen_name == post.screen_name &&
    time_of_post == post.time_of_post &&
    media_url == post.media_url &&
    source == post.source &&
    post_id == post.post_id
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

  def self.sorted_posts(hashtag=false, limit=nil)
    limit ? all(hashtag).order(time_of_post: :desc).limit(limit) : all(hashtag).order(time_of_post: :desc)
  end

  def self.next_posts(last_post_id, limit=nil)
    last_post = find(last_post_id)
    return where("time_of_post < ?", last_post.time_of_post).order(time_of_post: :desc).limit(limit) if limit
    where("time_of_post < ?", last_post.time_of_post).order(time_of_post: :desc)
  end


private

  def self.is_post_from_last_pull?(post)
    post.created_at > APIService.instance.last_update
  end
end
