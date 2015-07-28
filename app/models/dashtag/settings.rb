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

    validates :hashtags, presence: true
    validates :hashtags, format: { without: /(\b(?<!#)[a-zA-Z]+|\b[a-zA-Z]+\b((?=[^,])(?=\s[^&])|,\s*[^\w\s#]))/,  message: "list is not correctly formatted" }
    validates :api_rate, numericality: true, allow_nil: true
 
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