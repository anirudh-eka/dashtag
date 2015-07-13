module Dashtag
	class SettingService
    def self.hashtags
      Hashtags.new JSON.parse(find_setting_or_default("hashtags", "[]"))
    end

    def self.hashtags=(hashtags)
      create_or_update_setting("hashtags", Hashtags.parse(hashtags).to_json)
    end

    def self.twitter_users
      JSON.parse(find_setting_or_default("twitter_users", "[]"))
    end

    def self.twitter_users=(twitter_users)
      create_or_update_setting("twitter_users", parse_social_users(twitter_users))
    end

    def self.instagram_users
      JSON.parse(find_setting_or_default("instagram_users", "[]"))
    end

    def self.instagram_users=(instagram_users)
      create_or_update_setting("instagram_users", parse_social_users(instagram_users))
    end

    def self.instagram_user_ids
      JSON.parse(find_setting_or_default("instagram_user_ids", "[]"))
    end

    def self.instagram_user_ids=(instagram_user_ids)
      create_or_update_setting("instagram_user_ids", parse_social_users(instagram_user_ids))
    end

    def self.header_title
      find_setting_or_default("header_title", default_header_title)
    end

    def self.header_title=(header_title)
      create_or_update_setting("header_title", header_title)
    end

    def self.api_rate
      find_setting_or_default("api_rate", default_api_rate).to_i
    end

    def self.api_rate=(api_rate)
      create_or_update_setting("api_rate", integer_or_nil(api_rate))
    end

    def self.ajax_interval
      find_setting_or_default("ajax_interval", 5000).to_i
    end

    def self.ajax_interval=(ajax_interval)
      create_or_update_setting("ajax_interval", integer_or_nil(ajax_interval))
    end

    def self.db_row_limit
      find_setting_or_default("db_row_limit", 8000).to_i
    end

    def self.db_row_limit=(db_row_limit)
      create_or_update_setting("db_row_limit", integer_or_nil(db_row_limit))
    end

    def self.disable_retweets
      rehydrate_bool(find_setting_or_default("disable_retweets", "true"))
    end

    def self.disable_retweets=(disable_retweets)
      create_or_update_setting("disable_retweets", dehydrate_bool(disable_retweets))
    end

    private

    def self.dehydrate_bool(bool)
      return "false" if bool == false
      return "true" if bool == true
    end

    def self.rehydrate_bool(bool_as_string)
      return false if bool_as_string == "false"
      return true if bool_as_string == "true"
    end

    def self.value_or_default(setting, default)
      return default if setting.nil? || setting.value.nil?
      setting.value
    end

    def self.find_setting_or_default(name, default)
      setting = Setting.find_by(name: name)
      value_or_default(setting, default)
    end

    def self.create_or_update_setting(name, value)
      Setting.find_or_create_by(name: name).update(value: value)
    end

    def self.default_header_title
      hashtags.to_s
    end

    def self.parse_social_users(users)
      users.split(',').map {|user| user.gsub('@', '').strip}.to_json
    end

    def self.integer_or_nil(maybe_int)
      maybe_int.nil? ? nil : Integer(maybe_int)
    end

    def self.default_api_rate
      [6 * hashtags.flatten.uniq.count, 6 * twitter_users.count].max
    end
	end
end