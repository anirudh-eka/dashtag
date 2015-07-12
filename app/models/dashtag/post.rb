module Dashtag
  class Post < ActiveRecord::Base
    validates_presence_of :screen_name, :time_of_post, :profile_image_url, :source, :post_id
    validate :post_is_not_a_retweet
    validates_uniqueness_of :screen_name, scope: :time_of_post
    after_save :clear_oldest_post_if_limit_is_reached

    def as_json(options={})
      super.as_json().merge({formatted_time_of_post: time_of_post})
    end

    def self.get_new_posts(last_update_time)
      APIService.instance.pull_posts
      all_sorted_posts.select { |post| is_post_from_last_pull?(post, last_update_time) }
    end


    def self.all_sorted_posts
      all.order(time_of_post: :desc).reject{ |post| censored?(post)}
    end

    def self.limited_sorted_posts(limit)
      all_sorted_posts.first(limit)
    end

    def self.next_posts(last_post, limit=nil)
      return all_next_posts(last_post).first(limit) if limit
      all_next_posts(last_post)
    end

    def self.all_next_posts(last_post)
      all_sorted_posts.select{ |post| post.time_of_post < last_post.time_of_post }
    end

    def post_is_not_a_retweet
      errors.add(:text, "can't be a retweet") if EnvironmentService.disable_retweets && source == "twitter" && text.match(/(RT @[\S]+:)/)
    end

    private

    def self.censored?(post)
      ParserHelper.text_has_censored_words(post.text) || ParserHelper.user_is_censored(post.screen_name)
    end

    def self.is_post_from_last_pull?(post, last_update_time)
      post_is_newer_than_the_last_update_time = post.created_at.to_f > last_update_time
      return post_is_newer_than_the_last_update_time
    end

    def clear_oldest_post_if_limit_is_reached
      Post.all_sorted_posts.last.destroy! if Post.count > SettingService.db_row_limit
    end
  end
end
