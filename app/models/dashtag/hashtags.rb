module Dashtag
	class Hashtags < Array
		def to_s
      stringified = self.map do |inner_hashtags| 
        inner_hashtags.map {|hashtag| "##{hashtag}"}.join(" & ")
      end
      stringified.join(", ")
		end

    def self.parse(string)
      arr = string.split(",").map do |inner_hashtags| 
        inner_hashtags.gsub("#","").split("&").map { |hashtag| hashtag.strip }
      end
      Hashtags.new arr
    end
	end
end