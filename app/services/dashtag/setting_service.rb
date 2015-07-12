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

    private

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
      dehydrate_list(users.split(',').map {|user| user.gsub('@', '').strip})
    end

    def self.integer_or_nil(maybe_int)
      maybe_int.nil? ? nil : Integer(maybe_int)
    end

    def self.default_api_rate
      [6 * hashtags.flatten.uniq.count, 6 * twitter_users.count].max
    end

    def self.rehydrate_list(list)
      JSON.parse(value_or_default(list, "[]"))
    end

    def self.dehydrate_list(list)
      list.to_json
    end
	end
end