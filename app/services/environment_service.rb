class EnvironmentService
	def self.twitter_bearer_credentials
		return nil if ENV["TWITTER_BEARER_CREDENTIALS"] == ""
		ENV["TWITTER_BEARER_CREDENTIALS"]
	end

	def self.instagram_client_id
		return nil if ENV["INSTAGRAM_CLIENT_ID"] == ""
		ENV["INSTAGRAM_CLIENT_ID"]
	end

	def self.disable_retweets
    return nil unless ENV["DISABLE_RETWEETS"]
		ENV["DISABLE_RETWEETS"].downcase != "false"
	end

	def self.db_row_limit
		begin
			Integer(ENV["DB_ROW_LIMIT"])
		rescue ArgumentError, TypeError
			8000
		end
	end
end