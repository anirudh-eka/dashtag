require 'pry'
require 'singleton'

class APIService
  include Singleton
  attr_reader :last_update

  def initialize
    @last_update = Time.new(1720)
  end

  def pull_posts(hashtag)
    begin
      pull_posts!(hashtag)  
    rescue
      nil
    end
  end

  def pull_posts!(hashtag)
    rate_to_hit_api = ENV["API_Rate"] ? ENV["API_Rate"].to_f : 15

    if (Time.now - last_update > rate_to_hit_api)
      @last_update = Time.now

      parsed_response = []
      parsed_response += pull_instagram_posts_and_parse(hashtag) if ENV["INSTAGRAM_CLIENT_ID"] != ""
      parsed_response += pull_twitter_posts_and_parse(hashtag) if ENV["TWITTER_BEARER_CREDENTIALS"] != ""
      parsed_response.each do |attributes|
        Post.create(attributes)
      end
    else
      raise "Time since last pull is less than api rate limit"
    end
  end

  private

	def pull_instagram_posts_and_parse(hashtag)
    instagram_client_id = ENV["INSTAGRAM_CLIENT_ID"]
    response = HTTParty.get("https://api.instagram.com/v1/tags/#{hashtag}/media/recent?client_id=#{instagram_client_id}")

    GramParser.parse(response.parsed_response)
	end

  def pull_twitter_posts_and_parse(hashtag)
    response = HTTParty.get("https://api.twitter.com/1.1/search/tweets.json?q=%23#{hashtag}",
    :headers => { "Authorization" => "Bearer #{twitter_bearer_token}",
      "User-Agent" => "#NAAwayDay Feed v1.0"})
    TweetParser.parse(response.parsed_response)
  end

  def twitter_bearer_token
    authorization_key = Base64.encode64(ENV["TWITTER_BEARER_CREDENTIALS"]).gsub("\n","")
    
    resp = HTTParty.post('https://api.twitter.com/oauth2/token',
      :headers => { 
        "Authorization" => "Basic #{authorization_key}",
        "User-Agent" => "Hashtag Displayer Feed v1.0",
        "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
        },
      body: {"grant_type" => "client_credentials"}
    )
    resp["access_token"]
  end
end
