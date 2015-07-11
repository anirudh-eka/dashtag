module Dashtag
	class SettingService
    def self.hashtags
      hashtags_setting = Setting.find_by(name: "hashtags")
      Hashtags.new rehydrate_list(hashtags_setting)
    end

    def self.hashtags=(hashtags)
      parsed_hashtags = hashtags.split(",").map do |inner_hashtags| 
        inner_hashtags.gsub("#","").split("&").map { |hashtag| hashtag.strip }
      end
      Setting.find_or_create_by(name: "hashtags").update(value: parsed_hashtags.to_json)
    end

    def self.twitter_users
      twitter_users_setting = Setting.find_by(name: "twitter_users")
      rehydrate_list(twitter_users_setting)
    end

    def self.twitter_users=(twitter_users)
      parsed_twitter_users = twitter_users.split(',').map {|twitter_user| twitter_user.gsub('@', '').strip}
      Setting.find_or_create_by(name: "twitter_users").update(value: parsed_twitter_users.to_json)
    end

    def self.instagram_users
      instagram_users_setting = Setting.find_by(name: "instagram_users")
      rehydrate_list(instagram_users_setting)
    end

    def self.instagram_users=(instagram_users)
      parsed_instagram_users = instagram_users.split(',').map {|instagram_user| instagram_user.gsub('@', '').strip}
      Setting.find_or_create_by(name: "instagram_users").update(value: parsed_instagram_users.to_json)
    end

    def self.instagram_user_ids
      instagram_user_ids_setting = Setting.find_by(name: "instagram_user_ids")
      rehydrate_list(instagram_user_ids_setting)
    end

    def self.instagram_user_ids=(instagram_user_ids)
      parsed_instagram_user_ids = instagram_user_ids.split(',').map {|instagram_user_id| instagram_user_id.gsub('@', '').strip}
      Setting.find_or_create_by(name: "instagram_user_ids").update(value: parsed_instagram_user_ids.to_json)
    end

    def self.header_title
      header_title_setting = Setting.find_by(name: "header_title")
      return default_header_title if header_title_setting.nil? || header_title_setting.value.nil?
      header_title_setting.value
    end

    def self.header_title=(header_title)
      Setting.find_or_create_by(name: "header_title").update(value: header_title)
    end

    def self.api_rate
      api_rate_setting = Setting.find_by(name: "api_rate")
      return default_api_rate if api_rate_setting.nil? || api_rate_setting.value.nil?
      api_rate_setting.value.to_i
    end

    def self.api_rate=(api_rate)
      api_rate_as_integer_or_nil = api_rate.nil? ? nil : Integer(api_rate)
      Setting.find_or_create_by(name: "api_rate").update(value: api_rate_as_integer_or_nil)
    end

    private

    def self.default_header_title
      hashtags.to_s
    end

    def self.default_api_rate
      [6 * hashtags.flatten.uniq.count, 6 * twitter_users.count].max
    end

    def self.rehydrate_list(setting)
      return [] if setting.nil? || setting.value.nil?
      JSON.parse(setting.value)
    end
	end
end