module Dashtag
  class Settings
    attr_accessor :hashtags, 
    :twitter_users, 
    :instagram_users, 
    :instagram_user_ids, 
    :header_title, 
    :api_rate, 
    :db_row_limit, 
    :disable_retweets,
    :header_link,
    :twitter_consumer_key,
    :twitter_consumer_secret,
    :instagram_client_id,
    :censored_words,
    :censored_users,
    :font_family,
    :header_color,
    :background_color,
    :post_color_1,
    :post_color_2,
    :post_color_3,
    :post_color_4
    
  	extend ActiveModel::Naming
  	include ActiveModel::Conversion
    include ActiveModel::Validations

    SOCIAL_USERS_REGEX=/(\b(?<!@)[a-zA-Z]+|\b[a-zA-Z]+\b(?=[^,]))/
    HASHTAGS_REGEX=/(\b(?<!#)[a-zA-Z]+|\b[a-zA-Z]+\b((?=[^,])(?=\s[^&])|,\s*[^\w\s#]))/
    INSTAGRAM_USER_ID_REGEX=/((?<=[-.])\b[0-9]+\b|\b[0-9]+\b(?=[^,])|0|\b[^\d,]+\b)/
    CENSORED_WORD_REGEX=/\b\S+\b(?!,)(?!$)/

    validates :hashtags, format: { without: HASHTAGS_REGEX,  message: "list is not correctly formatted" }
    validates :twitter_users, format: { without: SOCIAL_USERS_REGEX,  message: "list is not correctly formatted" }
    validates :instagram_users, format: { without: SOCIAL_USERS_REGEX,  message: "list is not correctly formatted" }
    validates :instagram_user_ids, format: { without: INSTAGRAM_USER_ID_REGEX,  message: "ids must be positive integers greater than zero seperated by commas" }
    validates_length_of :header_title, maximum: 50
    validates :api_rate, numericality: true, :allow_blank => true
    validates :db_row_limit, numericality: true, :allow_blank => true
    validates_format_of :header_link, with: URI.regexp, allow_nil: true, unless: "header_link == '#hashtag-anchor'", message: "url must be valid starting with 'http' or 'https'"
    validates :censored_words, format: { without: CENSORED_WORD_REGEX,  message: "list is not correctly formatted" }
    validates :censored_users, format: { without: SOCIAL_USERS_REGEX,  message: "list is not correctly formatted" }

    validates_presence_of :twitter_consumer_secret, unless: "twitter_consumer_key.blank? && twitter_users.blank?"
    validates_presence_of :twitter_consumer_key, unless: "twitter_consumer_secret.blank? && twitter_users.blank?"
    validates_presence_of :instagram_client_id, unless: "instagram_users.blank? && instagram_user_ids.blank?"
    validates_absence_of :hashtags, if: "instagram_client_id.blank? && (twitter_consumer_key.blank? || twitter_consumer_secret.blank?)", message: "posts cannot be pulled by hashtags without an instagram client id or twitter consumer key and secret, please fill them in"

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def store
      if valid?
        settings_set_by_user.each do |name|
          SettingStore.create_or_update_setting(name, SettingStore::SETTING_TYPE[name].parse(send(name)))
        end
      end
    end

    def self.load_settings
      args = {}
      all_setting_names.each do |name|
        args[name] = SettingStore.find_setting_or_default(name).to_ui_format
      end
      new(args)
    end

	  def persisted?
	    false
	  end
	 
	  def id
	    nil
	  end

    private

    def self.all_setting_names
      SettingStore::SETTING_TYPE.keys
    end
    
    def settings_set_by_user
      instance_variable_names.select{|name| !["@errors", "@validation_context"].include?(name)}.map {|name| name.sub('@','')}
    end

    def value_or_default(setting, default)
      return default if setting.nil? || setting.value.nil?
      setting.value
    end

    def find_setting_or_default(name, default)
      setting = Setting.find_by(name: name)
      value_or_default(setting, default)
    end

    def create_or_update_setting(name, value)
      Setting.find_or_create_by(name: name).update(value: value)
    end
  end
end