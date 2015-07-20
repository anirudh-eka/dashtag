module Dashtag
  class SettingStore < ActiveRecord::Base
    self.table_name = "dashtag_settings"
  	validates_presence_of :name
    
    SETTING_TYPE = {"hashtags" => Hashtags, 
      "header_title" => TextSetting, 
      "api_rate" => NumSetting,
      "twitter_users" => SocialUsers,
      "instagram_users" => SocialUsers,
      "instagram_user_ids" => InstagramUserIds,
      "db_row_limit" => NumSetting,
      "disable_retweets" => BoolSetting,
      "header_link" => TextSetting,
      "twitter_consumer_key" => TextSetting,
      "twitter_consumer_secret" => TextSetting,
      "instagram_client_id" => TextSetting,
      "censored_words" => CensoredWords,
      "censored_users" => SocialUsers,
      "font_family" => TextSetting,
      "header_color" =>TextSetting,
      "background_color" =>TextSetting,
      "post_color_1" =>TextSetting,
      "post_color_2" =>TextSetting,
      "post_color_3" =>TextSetting,
      "post_color_4" =>TextSetting}

    SETTING_DEFAULTS = {"hashtags" => "[]",
      "twitter_users" => "[]",
      "instagram_users" => "[]",
      "instagram_user_ids" => "[]",
      "db_row_limit" => 8000,
      "disable_retweets" => true,
      "header_link" => "#hashtag-anchor",
      "twitter_consumer_key" => "",
      "twitter_consumer_secret" => "",
      "instagram_client_id" => "",
      "censored_words" => "[]",
      "censored_users" => "[]",
      "font_family" => "",
      "header_color" => "#EFEFEF",
      "background_color" => "#EFEFEF",
      "post_color_1" => "#B11C54",
      "post_color_2" => "#F78F31",
      "post_color_3" => "#80C9D2",
      "post_color_4" => "#B5B935"}

  	def self.create_or_update_setting(name, value)
      serialized = value.nil? ? nil : value.dehydrate
      find_or_create_by(name: name).update(value: serialized)
    end

    def self.find_setting_or_default(name)
      setting = find_by(name: name)
      value = value_or_default(setting, send("default_#{name}"))
      SETTING_TYPE[name].hydrate(value)
    end

    def self.default_header_title
      find_setting_or_default("hashtags").to_ui_format
    end

    def self.default_api_rate
      hashtags = find_setting_or_default("hashtags")
      twitter_users = find_setting_or_default("twitter_users")
      [6 * hashtags.flatten.uniq.count, 6 * twitter_users.count].max
    end

    def self.twitter_bearer_credentials
      "#{twitter_consumer_key.to_api_format}:#{twitter_consumer_secret.to_api_format}"
    end

    def self.method_missing(method, *args)
      method_as_string = method.to_s
      if method_as_string.start_with?("default_")
        SETTING_DEFAULTS[method_as_string.sub("default_", "")]
      elsif SETTING_TYPE.keys.include?(method_as_string)
        find_setting_or_default(method_as_string)
      else
        super
      end
    end

    private

    def self.value_or_default(setting, default)
      return default if setting.nil? || setting.value.nil?
      setting.value
    end
  end
end