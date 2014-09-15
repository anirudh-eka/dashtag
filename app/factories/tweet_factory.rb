class TweetFactory

  def self.make_tweets(parsed_response)
    parsed_response["statuses"].each do |tweet|
      
      text = tweet["text"]
      screen_name = tweet["user"]["screen_name"]
      created_at = tweet["created_at"]
      profile_image_url = tweet["user"]["profile_image_url"]

      media = tweet["entities"]["media"]
      media_url = (media ? media[0]["media_url_https"] : nil)

      unless text.match(/.*(#{ENV["CENSORED_WORDS"]}).*/i)         
        begin
          Tweet.create!(
            text: text,
            screen_name: screen_name,
            created_at: created_at,
            profile_image_url: profile_image_url,
            media_url: media_url
          )
        rescue 

        end
      end

    end
    Tweet.order(created_at: :desc).first
    
  end

end