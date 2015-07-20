require 'spec_helper'

module Dashtag
  describe CensoredWords do
    let(:censored_words_string) {"big, brother, is, watching"}
    
    it "should strip nonessential whitespace from censored words string when converting into CensoredWords" do
      censored_words_string = "\nbig, brother, is, watching\n\n"
      expect(CensoredWords.parse(censored_words_string)).to eq(["big", "brother", "is", "watching"])
    end

    it "should parse censored words string into CensoredWords" do
      censored_words = CensoredWords.parse(censored_words_string)
      expect(censored_words).to eq(["big", "brother", "is", "watching"])
      expect(censored_words.to_ui_format).to eq("big, brother, is, watching")
    end

    it "should stringify correctly for censored_words" do 
      censored_words = CensoredWords.parse(censored_words_string)
      expect(censored_words.to_ui_format).to eq(censored_words_string)
    end

    it "should dehydrate itself" do
      censored_words = CensoredWords.parse(censored_words_string)
      expect( censored_words.dehydrate ).to eq(["big", "brother", "is", "watching"].to_json)
    end

    it "should hydrate CensoredWords" do
      censored_words = CensoredWords.parse(censored_words_string)
      expect( CensoredWords.hydrate(censored_words.dehydrate)).to eq(CensoredWords.parse(censored_words_string))
    end
  end
end