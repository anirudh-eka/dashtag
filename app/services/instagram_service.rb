class InstagramService
	def self.get_grams_by_hashtag(hashtag)
	    instagram_client_id = ENV["INSTAGRAM_CLIENT_ID"]
	    response = HTTParty.get("https://api.instagram.com/v1/tags/#{hashtag}/media/recent?client_id=#{instagram_client_id}")
	    GramFactory.make_grams(response)
	    return response
  	end
end