module Dashtag
  class TweetParser

    def self.parse(response)
      @parsed_response = []
      response.class != Array ? build_tweets_from(response["statuses"]) : build_tweets_from(response)
      @parsed_response
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
      def self.build_tweets_from(response)
        response.each do |tweet|
          screen_name = tweet["user"]["screen_name"]
          text = replace_media_links(tweet)
          unless ParserHelper.text_has_censored_words(text) || ParserHelper.user_is_censored(screen_name)
            @parsed_response << { source: "twitter",
                                text: text,
                                screen_name: screen_name,
                                time_of_post: tweet["created_at"],
                                profile_image_url: tweet["user"]["profile_image_url"],
                                media_url: get_media_url(tweet),
                                post_id: tweet["id_str"] }
          end
        end
        @parsed_response
      end
  end
end
