module Dashtag
	class InstagramUserIds < SocialUsers
		def to_ui_format
      @users.join(", ")
		end

    def self.parse(string)
      InstagramUserIds.new string.split(",").map {|u| Integer(u) }
    end

    def self.hydrate(serialized)
      InstagramUserIds.new JSON.parse(serialized)
    end
	end
end