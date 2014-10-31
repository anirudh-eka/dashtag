require 'pry'
class Post < ActiveRecord::Base
	validates_presence_of :screen_name, :time_of_post, :profile_image_url, :source, :post_id
  validate :post_is_not_a_retweet
	validates_uniqueness_of :screen_name, scope: :time_of_post
  after_save :clear_oldest_post_if_limit_is_reached

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
    super().order(time_of_post: :desc)
  end

  def self.sorted_posts(hashtag=false, limit=nil)
    limit ? all(hashtag).limit(limit).reject{ |post| censored?(post)} : all(hashtag).reject{ |post| censored?(post)}
  end

  def self.next_posts(last_post_id, limit=nil)
    last_post = find(last_post_id)
    return all.where("time_of_post < ?", last_post.time_of_post).limit(limit).reject{ |post| censored?(post)} if limit
    all.where("time_of_post < ?", last_post.time_of_post).reject{ |post| censored?(post) }
  end

  def post_is_not_a_retweet
    errors.add(:text, "can't be a retweet") if EnvironmentService.disable_retweets && source == "twitter" && text.match(/(RT @[\S]+:)/)
  end

private

  def self.censored?(post)
    ParserHelper.text_has_censored_words(post.text) || ParserHelper.user_is_censored(post.screen_name)
  end

  def self.is_post_from_last_pull?(post)
    post.created_at > APIService.instance.last_update
  end

  def clear_oldest_post_if_limit_is_reached
    Post.order(time_of_post: :desc).last.destroy! if Post.count > EnvironmentService.db_row_limit
  end

end
