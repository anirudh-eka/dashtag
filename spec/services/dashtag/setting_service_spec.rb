require 'spec_helper'

module Dashtag
  describe SettingService do
    describe "hashtags" do
  	  it "should return an empty array if HASHTAGS hasn't been set" do
  	    expect(SettingService.hashtags).to be_empty
  	  end

  	  it "should parse comma delimeted hashtag list into a nested array" do
        SettingService.hashtags = "#peace, #love"
  	    expect(SettingService.hashtags).to eq([["peace"], ["love"]])
  	  end

  	  it "should parse '&' delimeted hashtag list into a nested array" do
        SettingService.hashtags = "#peace, #love & #turtles"
        expect(SettingService.hashtags).to eq([["peace"], ["love", "turtles"]])
      end

  	  it "should strip non-essential white space off hashtags" do
        SettingService.hashtags = "\n#yolo, #cool & #stuff\n\n"
        expect(SettingService.hashtags).to eq([['yolo'], ['cool', 'stuff']])
      end
    end

    describe "header title" do
      it "should return title when title set" do
        SettingService.header_title = "something"
        expect(SettingService.header_title).to eq("something")
      end

      it "should return string of the settings hashtags if title is nil" do
        SettingService.hashtags = "#peace, #love & #turtles"
        SettingService.header_title = nil
        expect(SettingService.header_title).to eq("#peace, #love & #turtles")
      end
    end

    describe "api_rate" do
      it "should return api_rate when set" do
        SettingService.api_rate = 10
        expect(SettingService.api_rate).to eq(10)
      end

      it "should limit api_rate to be set to values that can be converted to Integer" do
        expect { SettingService.api_rate = "sdhkfj" }.to raise_error
      end

      context "when setting not set" do
        context "and hashtag count is greater than user count" do 
          it "should return 6 * hashtag count" do
            SettingService.hashtags = "#peace, #love & #turtles"
            SettingService.api_rate = nil
            expect(SettingService.api_rate).to eq(18)
          end
        end
        context "and user count is greater than hashtag count" do 
          xit "should return 6 * user count" do
    #     ENV["TWITTER_USERS"] = "my|screen|name|4th_user|g3"
    #     users_count = EnvironmentService.twitter_users.count
    #     ENV["API_RATE"] = ""
    #     expect(EnvironmentService.api_rate).to eq(6 * users_count)
          end
        end
      end
    end
  end
end