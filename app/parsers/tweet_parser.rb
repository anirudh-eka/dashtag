class TweetParser

  def self.parse(response)
    parsed_response = []
    # binding.pry
    response.class != Array ? response["statuses"].each {|tweet| self.parse_tweet(tweet, parsed_response)} :
                           response.each {|tweet| self.parse_tweet(tweet, parsed_response)}

    # binding.pry
    parsed_response
  end

  def self.get_media_url(tweet)
    media = tweet["entities"]["media"]
    return media ? media[0]["media_url_https"] : nil
  end

  def self.replace_media_links(tweet)
    replace_short_links strip_photo_url(tweet)
  end

  def self.strip_photo_url(tweet)
    media_link = get_media_url(tweet)

    return tweet if media_link.nil?

    tweet["text"].gsub! media_link.to_s, ''

    tweet
  end

  def self.replace_short_links(tweet)
    urls = tweet["entities"]["urls"]

    return tweet["text"] if urls.empty?

    urls.each do |url|
      tweet["text"].gsub! url["url"].to_s, url["expanded_url"].to_s
    end

    tweet["text"]
  end

  private

    def self.parse_tweet(tweet, parsed_response)
    screen_name = tweet["user"]["screen_name"]
      text = replace_media_links(tweet)

      unless ParserHelper.text_has_censored_words(text) || ParserHelper.user_is_censored(screen_name)
        parsed_response << { source: "twitter",
                            text: text,
                            screen_name: screen_name,
                            time_of_post: tweet["created_at"],
                            profile_image_url: tweet["user"]["profile_image_url"],
                            media_url: get_media_url(tweet),
                            post_id: tweet["id_str"] }
      end
    end
end
