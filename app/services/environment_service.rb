class EnvironmentService
	def self.hashtag_array
		ENV["HASHTAGS"] == "" || !ENV["HASHTAGS"] ? [] : ENV["HASHTAGS"].split("|")
	end

	def self.twitter_bearer_credentials
		ENV["TWITTER_BEARER_CREDENTIALS"] == "" ? nil : ENV["TWITTER_BEARER_CREDENTIALS"]
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

	def self.api_rate
		begin
			Integer(ENV["API_RATE"])
		rescue ArgumentError, TypeError
			15
		end
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

	def self.color_1
		ENV["COLOR_1"]
	end

	def self.color_2
		ENV["COLOR_2"]
	end

	def self.color_3
		ENV["COLOR_3"]
	end

	def self.color_4
		ENV["COLOR_4"]
	end
end
