class TweetParser

  def self.parse(response)
    parsed_response = []
    response["statuses"].each do |tweet|
      
      text = tweet["text"]
      screen_name = tweet["user"]["screen_name"]
      created_at = tweet["created_at"]
      profile_image_url = tweet["user"]["profile_image_url"]

      media = tweet["entities"]["media"]
      media_url = (media ? media[0]["media_url_https"] : nil)

      unless text_has_censored_words(text) || user_is_censored(screen_name)
        parsed_response << { source: "twitter",
                            text: text,
                            screen_name: screen_name,
                            time_of_post: created_at,
                            profile_image_url: profile_image_url,
                            media_url: media_url }
      end
    end
    return parsed_response
  end

  private

  def self.text_has_censored_words(text)
    (text && text.match(/.*(#{ENV["CENSORED_WORDS"]}).*/i))
  end

  def self.user_is_censored(screen_name)
    (screen_name && screen_name.match(/.*(#{ENV["CENSORED_USERS"]}).*/i))   
  end
end