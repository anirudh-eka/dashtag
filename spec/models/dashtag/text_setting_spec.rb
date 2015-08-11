require 'spec_helper'

module Dashtag
  describe TextSetting do
    it "should return input string for ui format" do 
      text = TextSetting.new("hi there")
      expect(text.to_ui_format).to eq("hi there")
    end

    it "should parse string into TextSetting" do
      text = TextSetting.new("hi there")
      expect(text).to eq(TextSetting.new("hi there"))
    end

    it "should strip nonessential whitespace from users string when converting into SocialUsers" do
      users_string = "\nrandom stuff\n\n"
      expect(TextSetting.parse (users_string)).to eq("random stuff")
    end

    it "should dehydrate itself" do
      text = TextSetting.new("yea")
      expect( text.dehydrate ).to eq("yea")
    end

    it "should hydrate a TextSetting" do
      text = TextSetting.new("hello")
      expect( TextSetting.hydrate(text.dehydrate)).to eq(TextSetting.new("hello"))
    end
  end
end
