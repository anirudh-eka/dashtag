module Dashtag
	class EnvironmentService
		def self.header_link
			ENV["HEADER_LINK"]  == "" || !ENV["HEADER_LINK"] ? "#hashtag-anchor" : ENV["HEADER_LINK"]
		end

		def self.twitter_bearer_credentials
			return nil if ENV["TWITTER_CONSUMER_KEY"] == nil || ENV["TWITTER_CONSUMER_SECRET"] == nil
			return nil if ENV["TWITTER_CONSUMER_KEY"] == "" || ENV["TWITTER_CONSUMER_SECRET"] == ""
			ENV["TWITTER_CONSUMER_KEY"] + ":" + ENV["TWITTER_CONSUMER_SECRET"]
		end

		def self.instagram_client_id
			ENV["INSTAGRAM_CLIENT_ID"] == "" ? nil : ENV["INSTAGRAM_CLIENT_ID"]
		end

		def self.disable_retweets
	  		!ENV["DISABLE_RETWEETS"] ? true : ENV["DISABLE_RETWEETS"].downcase != "false"
		end

		def self.censored_words
			ENV["CENSORED_WORDS"] == "" ? nil : ENV["CENSORED_WORDS"]
		end

		def self.censored_users
			ENV["CENSORED_USERS"] == "" ? nil : ENV["CENSORED_USERS"]
		end

		def self.ajax_interval
			begin
				Integer(ENV["AJAX_INTERVAL"])
			rescue ArgumentError, TypeError
				5000
			end
		end

		def self.db_row_limit
			begin
				Integer(ENV["DB_ROW_LIMIT"])
			rescue ArgumentError, TypeError
				8000
			end
		end

		def self.font_family
			ENV["FONT_FAMILY"]
		end

		def self.header_color
			ENV["HEADER_COLOR"]
		end

		def self.background_color
			ENV["BACKGROUND_COLOR"]
		end

		def self.post_color_1
			ENV["POST_COLOR_1"]
		end

		def self.post_color_2
			ENV["POST_COLOR_2"]
		end

		def self.post_color_3
			ENV["POST_COLOR_3"]
		end

		def self.post_color_4
			ENV["POST_COLOR_4"]
		end
	end
end
