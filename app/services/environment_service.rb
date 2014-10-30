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
    	return true unless ENV["DISABLE_RETWEETS"]
		ENV["DISABLE_RETWEETS"].downcase != "false"
	end

	def self.db_row_limit
		begin
			Integer(ENV["DB_ROW_LIMIT"])
		rescue ArgumentError, TypeError
			8000
		end
	end

	def self.color_1
		return color(1, "rgb(177, 28, 84)")
	end

	def self.color_2
		return color(2, "rgb(247, 143, 49)")
	end

	def self.color_3
		return color(3, "rgb(128, 201, 210)")
	end

	def self.color_4
		return color(4, "rgb(181, 185, 53)")
	end

	private

	def self.color(num, default_color)
		return default_color if ENV["COLOR_#{num}"] == nil || ENV["COLOR_#{num}"] == ""
		ENV["COLOR_#{num}"]
	end
end