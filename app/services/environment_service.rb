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
		ENV["DISABLE_RETWEETS"] != "false"
	end
end