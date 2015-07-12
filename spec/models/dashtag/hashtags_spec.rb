require 'spec_helper'

module Dashtag
  describe Hashtags do
    it "should stringify correctly for hashtags" do 
      hashtags = Hashtags.new([["peace"], ["love"]])
      expect(hashtags.to_s).to eq("#peace, #love")
    end

  	it "should stringify correctly for hashtags with &" do 
  		hashtags = Hashtags.new([["peace"], ["love", "turtles"]])
  		expect(hashtags.to_s).to eq("#peace, #love & #turtles")
  	end

    it "should stringify correctly for empty hashtag" do 
      hashtags = Hashtags.new()
      expect(hashtags.to_s).to eq("")
    end

    it "should parse hashtag string into Hashtags" do
      hashtag_string = "#peace, #love & #turtles"
      hashtags = Hashtags.parse (hashtag_string)
      expect(hashtags).to eq(Hashtags.new([["peace"], ["love", "turtles"]]))
      expect(hashtags.to_s).to eq("#peace, #love & #turtles")
    end
  end
end