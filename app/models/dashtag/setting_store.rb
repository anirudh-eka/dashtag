require_dependency "dashtag/settings_accessor_setter"

module Dashtag
  class SettingStore < ActiveRecord::Base
    self.table_name = "dashtag_settings"
    extend SettingsAccessorSetter
    attr_accessor_all_settings
    CENSORED_WORD_REGEX=/\b\S+\b(?!,)(?!$)/
    SOCIAL_USERS_REGEX=/(\b(?<!@)[a-zA-Z]+|\b[a-zA-Z]+\b(?=[^,]))/
    INSTAGRAM_USER_ID_REGEX=/((?<=[-.])\b[0-9]+\b|\b[0-9]+\b(?=[^,])|0|\b[^\d,]+\b)/
    HASHTAGS_REGEX=/(\b(?<!#)[a-zA-Z]+|\b[a-zA-Z]+\b((?=[^,])(?=\s[^&])|,\s*[^\w\s#]))/

    validates_length_of :header_title, maximum: 50
    validates :api_rate, numericality: true, :allow_blank => true
    validates :db_row_limit, numericality: true, :allow_blank => true
    validates_format_of :header_link, with: URI.regexp, allow_nil: true, unless: "header_link == '#hashtag-anchor'", message: "url must be valid starting with 'http' or 'https'"
    validates :censored_words, format: { without: CENSORED_WORD_REGEX,  message: "list is not correctly formatted" }
    validates :censored_users, format: { without: SOCIAL_USERS_REGEX,  message: "list is not correctly formatted" }
    validates :twitter_users, format: { without: SOCIAL_USERS_REGEX,  message: "list is not correctly formatted" }
    validates :instagram_user_ids, format: { without: INSTAGRAM_USER_ID_REGEX,  message: "ids must be positive integers greater than zero seperated by commas" }
    validates :instagram_users, format: { without: SOCIAL_USERS_REGEX,  message: "list is not correctly formatted" }
    validates :hashtags, format: { without: HASHTAGS_REGEX,  message: "list is not correctly formatted" }

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

    SETTING_DEFAULTS = {
      "db_row_limit" => 8000,
      "disable_retweets" => true,
      "header_link" => "#hashtag-anchor",
      "header_color" => "#EFEFEF",
      "background_color" => "#EFEFEF",
      "post_color_1" => "#B11C54",
      "post_color_2" => "#F78F31",
      "post_color_3" => "#80C9D2",
      "post_color_4" => "#B5B935"}

    def self.find_setting_or_default(name)
      setting = find_by(name: name)
      value = value_or_default(setting, send("default_#{name}"))
      SETTING_TYPE[name].parse(value)
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
      unless twitter_consumer_key.empty? || twitter_consumer_secret.empty?
        "#{twitter_consumer_key.to_api_format}:#{twitter_consumer_secret.to_api_format}"
      end
    end

    def self.method_missing(method, *args)
      method_as_string = method.to_s
      if method_as_string.start_with?("default_")
        SETTING_DEFAULTS[method_as_string.sub("default_", "")] || ""
      elsif SETTING_TYPE.keys.include?(method_as_string)
        find_setting_or_default(method_as_string)
      else
        super
      end
    end

    #store is how to save setting instance into the db  
    def store
      return nil if invalid?
      settings_changed_by_client.each do |name|
        SettingStore.create_or_update_setting(name, send(name)) 
      end
    end

    private

    def self.create_or_update_setting(name, value)
      serialized = value.nil? ? nil : value.to_s
      find_or_create_by(name: name).update(value: serialized)
    end

    def settings_changed_by_client
      instance_variable_names.map {|v| v.sub("@", "")} & SettingStore::SETTING_TYPE.keys
    end

    def self.value_or_default(setting, default)
      return default if setting.nil? || setting.value.blank?
      setting.value
    end
  end
end