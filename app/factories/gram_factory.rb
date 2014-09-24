class GramFactory

  def self.make_grams(parsed_response)
    parsed_response["data"].each do |gram|
      
      text = (gram["caption"] && gram["caption"]["text"]) || String.new
      
      
      return if text && text.match(/.*(#{ENV["CENSORED_WORDS"]}).*/i)   

      unless gram["images"].nil?
        unless gram["images"]["standard_resolution"].nil?
            media_url = gram["images"]["standard_resolution"]["url"]
        end
      end
      
      screen_name = gram["user"]["username"]
      profile_image_url = gram["user"]["profile_picture"]
      created_at = DateTime.strptime(gram["created_time"], "%s")


      begin
        Post.create!(
          source: "instagram",
          text: text, 
          screen_name: screen_name,
          media_url: media_url,
          profile_image_url: profile_image_url,
          created_at: created_at
          )
      rescue
      end
    end
  end
end