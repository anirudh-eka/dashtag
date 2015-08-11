require_dependency "dashtag/settings_accessor_setter"

module Dashtag
  class Settings
    extend SettingsAccessorSetter
  	extend ActiveModel::Naming
  	include ActiveModel::Conversion
    include ActiveModel::Validations
    attr_accessor_all_settings

    validates_presence_of :twitter_consumer_secret, unless: "twitter_consumer_key.blank?"
    validates_presence_of :twitter_consumer_key, unless: "twitter_consumer_secret.blank?"
    validates_absence_of :twitter_users, if: "twitter_consumer_secret.blank? || twitter_consumer_key.blank?",  message: "posts cannot be pulled by Twitter users without a Twitter consumer key and secret, please fill them in"
    validates_absence_of :instagram_users, if: "instagram_client_id.blank?",  message: "posts cannot be pulled by Instagram users without an Instagram client ID, please fill it in"
    validates_absence_of :instagram_user_ids, if: "instagram_client_id.blank?",  message: "posts cannot be pulled by Instagram user IDs without an Instagram client ID, please fill it in"
    validates_absence_of :hashtags, if: "instagram_client_id.blank? && (twitter_consumer_key.blank? || twitter_consumer_secret.blank?)", message: "posts cannot be pulled by hashtags without an Instagram client ID or twitter consumer key and secret, please fill them in"

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def store
      if valid?
        settings_set_by_user.each do |name|
          SettingStore.new({name.to_sym => send(name.to_sym)}).store
          # SettingStore.create_or_update_setting(name, SettingStore::SETTING_TYPE[name].parse(send(name)))
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

    def valid?
      result = super
      settings_set_by_user.each do |name|
        setting_store = SettingStore.new({name.to_sym => send(name.to_sym)})
        if setting_store.invalid?
          result = false
          store_errors = setting_store.errors.messages[name.to_sym]
          break if store_errors == nil 
          store_errors.each do |store_error|
            errors.messages[name.to_sym] ||= []
            errors.messages[name.to_sym] << store_error
          end
        end
      end
      result
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