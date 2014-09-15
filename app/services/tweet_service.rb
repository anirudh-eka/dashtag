class TweetService

  def self.get_tweets_by_hashtag(hashtag)
    response = HTTParty.get("https://api.twitter.com/1.1/search/tweets.json?q=%23#{hashtag}", 
      :headers => { "Authorization" => "Bearer #{bearer_token}",
        "User-Agent" => "#NAAwayDay Feed v1.0"})
    TweetFactory.make_tweets(response.parsed_response)
  end

  private

  def self.bearer_token
    authorization_key = Base64.encode64(ENV["TWITTER_BEARER_CREDENTIALS"]).gsub("\n","")
    
    resp = HTTParty.post('https://api.twitter.com/oauth2/token',
      :headers => { 
        "Authorization" => "Basic #{authorization_key}",
        "User-Agent" => "#NAAwayDay Feed v1.0",
        "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
        },
      body: {"grant_type" => "client_credentials"}
    )
    resp["access_token"]
  end

end