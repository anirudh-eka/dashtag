module Dashtag
	class TextSetting
    
    def initialize(text)
      @text = text
    end

    def dehydrate
      @text
    end
  
    def self.parse(string)
      string.nil? ? nil : new(string.strip)
    end

    def self.hydrate(string)
      new(string)
    end

    def to_ui_format
      @text
    end

    def to_api_format
      @text
    end

    def ==(other)
      return other == @text if other.class == TextSetting
      @text == other
    end
	end
end