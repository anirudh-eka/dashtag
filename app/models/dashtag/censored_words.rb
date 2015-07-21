module Dashtag
	class CensoredWords
  	def dehydrate
  	  @words.to_json
  	end

  	def to_ui_format
  	  @words.join(", ")
  	end

  	def self.parse(string)
  	  new string.split(",").map {|word| word.strip}
  	end

  	def self.hydrate(serialized)
  	  CensoredWords.new JSON.parse(serialized)
  	end

  	def ==(arg)
  	  return arg == @words if arg.is_a? CensoredWords
  	  @words == arg
  	end

  	def method_missing(method, *args, &block)
  	  @words.send(method.to_s, *args, &block)
  	end

    private
    def initialize(words)
      @words = words
    end 
	end
end