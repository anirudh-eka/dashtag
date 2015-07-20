module Dashtag
	class Hashtags

    def initialize hashtags
      @hashtags = hashtags
    end

    def dehydrate
      @hashtags.to_json
    end

		def to_ui_format
      stringified = @hashtags.map do |inner_hashtags| 
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

    def self.hydrate(serialized)
      Hashtags.new JSON.parse(serialized)
    end

    def ==(arg)
      return arg == @hashtags if arg.class == Hashtags
      @hashtags == arg
    end

    def method_missing(method, *args)
      @hashtags.send(method.to_s, *args)
    end
	end
end