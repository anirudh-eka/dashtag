module Dashtag
	class Hashtags < Array
		def to_s
      stringified = self.map do |inner_hashtags| 
        inner_hashtags.map {|hashtag| "##{hashtag}"}.join(" & ")
      end
      stringified.join(", ")
		end
	end
end