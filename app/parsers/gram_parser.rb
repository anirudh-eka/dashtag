class GramParser

  def self.parse(response)
    parsed_response = []
    response["data"].each do |gram|
    
      text = (gram["caption"] && gram["caption"]["text"]) || String.new
      screen_name = gram["user"]["username"]
      
      
      unless text_has_censored_words(text) || user_is_censored(screen_name)

        unless gram["images"].nil?
          unless gram["images"]["standard_resolution"].nil?
              media_url = gram["images"]["standard_resolution"]["url"]
          end
        end
        
        profile_image_url = gram["user"]["profile_picture"]
        created_at = DateTime.strptime(gram["created_time"], "%s")

        parsed_response << {
            source: "instagram",
            text: text, 
            screen_name: screen_name,
            media_url: media_url,
            profile_image_url: profile_image_url,
            time_of_post: created_at
            }
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