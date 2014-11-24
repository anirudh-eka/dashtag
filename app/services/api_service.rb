require 'singleton'

class APIService
  include Singleton
  attr_reader :last_update

  def initialize
    @last_update = Time.new(1720)
  end

  def pull_posts
    begin
      pull_posts!
    rescue
      nil
    end
  end

  def pull_posts!
    if (Time.now - last_update > EnvironmentService.api_rate)

      @last_update = Time.now

      parsed_responses = []

      EnvironmentService.hashtag_array.each do |hashtag|
        parsed_responses += pull_instagram_posts_and_parse(hashtag) if EnvironmentService.instagram_client_id
        parsed_responses += pull_twitter_posts_and_parse(hashtag) if EnvironmentService.twitter_bearer_credentials
      end

      EnvironmentService.twitter_users.each do |user|
        parsed_responses += pull_twitter_posts_from_users_and_parse(user) if EnvironmentService.twitter_bearer_credentials
      end

      EnvironmentService.instagram_user_ids.each do |user_id|
        parsed_responses += pull_instagram_posts_from_users_and_parse(user_id) if EnvironmentService.instagram_client_id
      end

      parsed_responses.each do |attributes|
        Post.create(attributes)
      end
    else
      raise "Time since last pull is less than api rate limit"
    end
  end

  private

  	def pull_instagram_posts_and_parse(hashtag)
      instagram_client_id = EnvironmentService.instagram_client_id
      response = HTTParty.get("https://api.instagram.com/v1/tags/#{hashtag}/media/recent?client_id=#{instagram_client_id}")
      GramParser.parse(response.parsed_response)
  	end

    def pull_instagram_posts_from_users_and_parse(user_id)
      instagram_client_id = EnvironmentService.instagram_client_id
      response = HTTParty.get("https://api.instagram.com/v1/users/#{user_id}/media/recent/?client_id=#{instagram_client_id}")
      GramParser.parse(response.parsed_response)
    end

    def pull_twitter_posts_and_parse(hashtag)
      response = HTTParty.get("https://api.twitter.com/1.1/search/tweets.json?q=%23#{hashtag}",
      :headers => { "Authorization" => "Bearer #{twitter_bearer_token}",
        "User-Agent" => "#NAAwayDay Feed v1.0"})
      TweetParser.parse(response.parsed_response)
    end

    def pull_twitter_posts_from_users_and_parse(screen_name)
      response = HTTParty.get("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=#{screen_name}&count=50", :headers => { "Authorization" => "Bearer #{twitter_bearer_token}", "User-Agent" => "#NAAwayDay Feed v1.0"})
      TweetParser.parse(response.parsed_response)
    end

    def twitter_bearer_token
      authorization_key = Base64.encode64(EnvironmentService.twitter_bearer_credentials).gsub("\n","")
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
