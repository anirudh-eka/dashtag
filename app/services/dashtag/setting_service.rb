module Dashtag
	class SettingService
    def self.hashtags
      hashtags_setting = Setting.find_by(name: "hashtags")
      return Hashtags.new if hashtags_setting.nil? || hashtags_setting.value.nil?
      Hashtags.new(JSON.parse (hashtags_setting.value))
    end

    def self.hashtags=(hashtags)
      parsed_hashtags = hashtags.split(",").map do |inner_hashtags| 
        inner_hashtags.gsub("#","").split("&").map { |hashtag| hashtag.strip }
      end
      Setting.find_or_create_by(name: "hashtags").update(value: parsed_hashtags.to_json)
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
      [6 * hashtags.flatten.uniq.count, 6 * EnvironmentService.twitter_users.count].max
    end
	end
end