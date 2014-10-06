class TweetParser

  def self.parse(response)
    parsed_response = []
    response["statuses"].each do |tweet|
      
      screen_name = tweet["user"]["screen_name"]
      created_at = tweet["created_at"]
      profile_image_url = tweet["user"]["profile_image_url"]

      media = tweet["entities"]["media"]
      media_url = (media ? media[0]["media_url_https"] : nil)

      post_id = tweet["id_str"]

      text = replace_media_links(tweet)

      unless ParserHelper.text_has_censored_words(text) || ParserHelper.user_is_censored(screen_name)
        parsed_response << { source: "twitter",
                            text: text,
                            screen_name: screen_name,
                            time_of_post: created_at,
                            profile_image_url: profile_image_url,
                            media_url: media_url,
                            post_id: post_id  }
      end
    end
    return parsed_response
  end

  def self.replace_media_links(tweet)
    replace_links_with_youtube strip_photo_url(tweet)
  end

  def self.strip_photo_url(tweet)
    media = tweet["entities"]["media"]
    media_link = (media ? media[0]["url"] : nil)

    return tweet if media_link.nil? 

    tweet["text"].gsub! media_link.to_s, ''

    tweet
  end

  def self.replace_links_with_youtube(tweet)
    urls = tweet["entities"]["urls"]

    return tweet["text"] if urls.empty? 

    urls.each do |url|
      tweet["text"].gsub! url["url"].to_s, url["expanded_url"].to_s
    end

    tweet["text"]
  end
end
