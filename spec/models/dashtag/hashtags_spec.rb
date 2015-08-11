require 'spec_helper'

module Dashtag
  describe Hashtags do
    let(:hashtag_list) {[["peace"], ["love"]]}
    it "should stringify correctly for hashtags" do 
      hashtags = Hashtags.new([["peace"], ["love"]])
      expect(hashtags.to_ui_format).to eq("#peace, #love")
    end

  	it "should stringify correctly for hashtags with &" do 
  		hashtags = Hashtags.new([["peace"], ["love", "turtles"]])
  		expect(hashtags.to_ui_format).to eq("#peace, #love & #turtles")
  	end

    it "should parse hashtag string into Hashtags" do
      hashtag_string = "#peace, #love & #turtles"
      hashtags = Hashtags.parse (hashtag_string)
      expect(hashtags).to eq(Hashtags.new([["peace"], ["love", "turtles"]]))
      expect(hashtags.to_ui_format).to eq("#peace, #love & #turtles")
    end

    it "should strip nonessential whitespace from hashtag string when converting into Hashtags" do
      hashtag_string = "\n#yolo, #cool & #stuff\n\n"
      expect(Hashtags.parse (hashtag_string)).to eq([['yolo'], ['cool', 'stuff']])
    end

    it "should dehydrate itself" do
      hashtags = Hashtags.new(hashtag_list)
      expect( hashtags.dehydrate ).to eq(hashtag_list.to_json)
    end

    it "should hydrate a hashtag" do
      hashtags = Hashtags.new(hashtag_list)
      expect( Hashtags.hydrate(hashtags.dehydrate)).to eq(Hashtags.new(hashtag_list))
    end
  end
end