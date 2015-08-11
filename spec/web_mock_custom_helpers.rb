module WebMockCustomHelpers
  def stub_all_external_api_requests_with_current_settings
  	stub_twitter_requests
    stub_instagram_requests
  end

  private

  def stub_instagram_requests
    stub_instagram_hashtag_requests
    stub_instagram_user_requests
  end

  def stub_twitter_requests
  	stub_twitter_oauth_handshake_request
  	stub_twitter_hashtag_requests
    stub_twitter_user_requests
  end

  def stub_twitter_oauth_handshake_request
  	auth_response = {"access_token"=>"ACCESS_TOKEN",
     "token_type"=>"bearer"}.to_json

    stub_request(:post, /https:\/\/#{Dashtag::SettingStore.twitter_bearer_credentials}@api.twitter.com\/oauth2\/token/).
      with(headers: {"content-type"=>"application/x-www-form-urlencoded;charset=UTF-8"},
        body: {"grant_type"=>"client_credentials"}).
      to_return({status: 200, body: auth_response, headers: {'content-type' => 'application/json'} })
  end

  def stub_twitter_hashtag_requests
  	Dashtag::SettingStore.hashtags.each do |hashtags|
      hashtag_query = hashtags.map { |hashtag| "%23#{hashtag}" }.join("%20AND%20")
      stub_request(:get, "https://api.twitter.com/1.1/search/tweets.json?q=#{hashtag_query}").
      with(headers: {"Authorization"=>/Bearer .+/}).
      to_return( {:status => 200, :body => Dashtag::SampleTweetResponses.tweet_response.to_json, :headers => {'content-type' => 'application/json'} },
        {:status => 200, :body => Dashtag::SampleTweetResponses.second_tweet_response.to_json, :headers => {'content-type' => 'application/json'} })
    end
  end

  def stub_instagram_hashtag_requests
    Dashtag::SettingStore.hashtags.each do |hashtags|
      hashtags.each do |hashtag|
        stub_request(:get, "https://api.instagram.com/v1/tags/#{hashtag}/media/recent?client_id=#{Dashtag::SettingStore.instagram_client_id.to_ui_format}").
          to_return( {:status => 200, :body => Dashtag::SampleInstagramResponses.instagram_response.to_json, :headers => {'content-type' => 'application/json'}})
      end
    end
  end

  def stub_twitter_user_requests
    Dashtag::SettingStore.twitter_users.each do |user|
      stub_request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?count=50&screen_name=#{user}").
      with(headers: {"Authorization"=>/Bearer .+/}).
      to_return( {:status => 200, :body => Dashtag::SampleTweetResponses.user_tweet_response.to_json, :headers => {'content-type' => 'application/json'} })
    end
  end

  def stub_instagram_user_requests
    Dashtag::SettingStore.instagram_user_ids.each do |user_id|
      stub_request(:get, "https://api.instagram.com/v1/users/#{user_id}/media/recent/?client_id=#{Dashtag::SettingStore.instagram_client_id.to_ui_format}").
      to_return( {:status => 200, :body => Dashtag::SampleInstagramResponses.user_instagram_response.to_json, :headers => {'content-type' => 'application/json'}})
    end

    stub_request(:get, /.*api.instagram.com\/v1\/users\/search.*/).
    to_return( {:status => 200, :body => Dashtag::SampleInstagramResponses.instagram_response.to_json, :headers => {'content-type' => 'application/json'}})

    stub_request(:get, "https://api.instagram.com/v1/users/#{Dashtag::SampleInstagramResponses.instagram_response["data"].first["id"]}/media/recent/?client_id=#{Dashtag::SettingStore.instagram_client_id.to_ui_format}").
    to_return( {:status => 200, :body => Dashtag::SampleInstagramResponses.user_instagram_response.to_json, :headers => {'content-type' => 'application/json'}})
  end
end