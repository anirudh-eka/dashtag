module SettingsAccessorSetter
  SETTINGS = [:hashtags, 
      :twitter_users, 
      :instagram_users, 
      :instagram_user_ids, 
      :header_title, 
      :api_rate, 
      :db_row_limit, 
      :disable_retweets,
      :header_link,
      :twitter_consumer_key,
      :twitter_consumer_secret,
      :instagram_client_id,
      :censored_words,
      :censored_users,
      :font_family,
      :header_color,
      :background_color,
      :post_color_1,
      :post_color_2,
      :post_color_3,
      :post_color_4]
      
	def attr_accessor_all_settings
    attr_accessor *SETTINGS
	end
end