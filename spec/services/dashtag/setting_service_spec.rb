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
          it "should return 6 * user count" do
            SettingService.twitter_users = "@friends, @enemies, @dogs"
            SettingService.api_rate = nil
            expect(SettingService.api_rate).to eq(18)
          end
        end
      end
    end
    describe "twitter_users" do
      it "should return an empty array if twitter_users hasn't been set" do
        expect(SettingService.twitter_users).to be_empty
      end
      it 'should parse comma delimeted twitter users list into a 1d array' do
        SettingService.twitter_users = "@yolo, @dance, @christmas"
        expect(SettingService.twitter_users).to eq(['yolo', 'dance', 'christmas'])
      end
    end
    describe "instagram_users" do
      it "should return an empty array if twitter_users hasn't been set" do
        expect(SettingService.twitter_users).to be_empty
      end
      it 'should parse comma delimeted twitter users list into a 1d array' do
        SettingService.instagram_users = "@yolo, @dance, @christmas"
        expect(SettingService.instagram_users).to eq(['yolo', 'dance', 'christmas'])
      end
    end
  end
end


    # describe "instagram_users" do
    #   it 'should parse EnvironmentService.instagram_users into an array' do
    #     ENV["INSTAGRAM_USERS"] = "kingjames|trey5"
    #     expected_array = ['kingjames', 'trey5']
    #     expect(EnvironmentService.instagram_users).to eq(expected_array)
    #   end

    #   it "should return an empty array if instagram_users are not set in env" do
    #     ENV["INSTAGRAM_USERS"] = nil
    #     expect(EnvironmentService.instagram_users).to be_empty
    #   end

    #   it "should return an empty array if instagram_users are not set in env" do
    #     ENV["INSTAGRAM_USERS"] = ""
    #     expect(EnvironmentService.instagram_users).to be_empty
    #   end
    # end