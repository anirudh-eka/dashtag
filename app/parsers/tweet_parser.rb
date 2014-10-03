class TweetParser

  def self.strip_photo_url(text, url)
    return text if url.nil? 
    text.gsub! url.to_s, ''

    text
  end

  def self.parse(response)
    parsed_response = []
    response["statuses"].each do |tweet|
      
      screen_name = tweet["user"]["screen_name"]
      created_at = tweet["created_at"]
      profile_image_url = tweet["user"]["profile_image_url"]

      media = tweet["entities"]["media"]
      media_url = (media ? media[0]["media_url_https"] : nil)
      url = (media ? media[0]["url"] : nil)

      text = strip_photo_url(tweet["text"], url)
 
      unless ParserHelper.text_has_censored_words(text) || ParserHelper.user_is_censored(screen_name)
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
end
