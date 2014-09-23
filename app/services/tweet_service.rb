require 'singleton'

class TweetService
  include Singleton
  attr_reader :last_update
  def initialize
    @last_update = Time.new(1720)
  end

  def get_tweets_by_hashtag(hashtag)
    rate_set_in_env = ENV["API_Rate"] ? ENV["API_Rate"].to_f : nil
    if (Time.now - @last_update > (rate_set_in_env || 15))
      response = HTTParty.get("https://api.twitter.com/1.1/search/tweets.json?q=%23#{hashtag}",
      :headers => { "Authorization" => "Bearer #{bearer_token}",
        "User-Agent" => "#NAAwayDay Feed v1.0"})
      TweetFactory.make_tweets(response.parsed_response)
      @last_update = Time.now
    else
      p '-' * 80
    end
  end

  private

  def bearer_token
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