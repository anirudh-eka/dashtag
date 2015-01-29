module Dashtag
  class GramParser

    def self.parse(response)
      parsed_response = []
      response["data"].each do |gram|

        text = (gram["caption"] && gram["caption"]["text"]) || String.new
        screen_name = gram["user"]["username"]

        post_id = gram["link"].split("/").last

        unless ParserHelper.text_has_censored_words(text) || ParserHelper.user_is_censored(screen_name)

          profile_image_url = gram["user"]["profile_picture"]
          created_at = DateTime.strptime(gram["created_time"], "%s")

          parsed_response << {
              source: "instagram",
              text: text,
              screen_name: screen_name,
              media_url: extract_image_url_if_image(gram),
              profile_image_url: profile_image_url,
              time_of_post: created_at,
              post_id: post_id
              }
        end
      end
      return parsed_response
    end

    def self.extract_image_url_if_image(gram)
      return nil if gram["type"] == "video"

      unless gram["images"].nil?
        unless gram["images"]["standard_resolution"].nil?
         return gram["images"]["standard_resolution"]["url"]
        end
      end
    end

  end
end
