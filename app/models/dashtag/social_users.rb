module Dashtag
	class SocialUsers
    def initialize(users)
      @users = users
    end 

    def dehydrate
      @users.to_json
    end

		def to_ui_format
      stringified = @users.map do |user| 
        "@#{user}"
      end
      stringified.join(", ")
		end

    def self.parse(string)
      arr = string.split(",").map do |user| 
        user.gsub("@","").strip
      end
      SocialUsers.new arr
    end

    def self.hydrate(serialized)
      SocialUsers.new JSON.parse(serialized)
    end

    def ==(arg)
      return arg == @users if arg.is_a? SocialUsers
      @users == arg
    end

    def method_missing(method, *args)
      @users.send(method.to_s, *args)
    end
	end
end