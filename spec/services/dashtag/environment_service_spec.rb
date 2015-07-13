require 'spec_helper'

module Dashtag
  describe EnvironmentService do
    before(:each) do
      @default_key = ENV["TWITTER_CONSUMER_KEY"]
      @default_secret = ENV["TWITTER_CONSUMER_SECRET"]
      @default_header_link = ENV["HEADER_LINK"]
      @default_censored_words = ENV["CENSORED_WORDS"]
      @default_instagram_client_id = ENV["INSTAGRAM_CLIENT_ID"]
      @default_censored_users = ENV["CENSORED_USERS"]
      @test_font_family = ENV["FONT_FAMILY"]
      @test_header_color = ENV["HEADER_COLOR"]
      @test_background_color = ENV["BACKGROUND_COLOR"]
      @test_post_color_1 = ENV["POST_COLOR_1"]
      @test_post_color_2 = ENV["POST_COLOR_2"]
      @test_post_color_3 = ENV["POST_COLOR_3"]
      @test_post_color_4 = ENV["POST_COLOR_4"]
    end

    after(:each) do
      ENV["TWITTER_CONSUMER_KEY"] = @default_key
      ENV["TWITTER_CONSUMER_SECRET"] = @default_secret
      ENV["HEADER_LINK"] =  @default_header_link
      ENV["CENSORED_WORDS"] = @default_censored_words
      ENV["INSTAGRAM_CLIENT_ID"] = @default_instagram_client_id
      ENV["CENSORED_USERS"] = @default_censored_users
      ENV["FONT_FAMILY"] =  @test_font_family
      ENV["HEADER_COLOR"] = @test_header_color
      ENV["BACKGROUND_COLOR"] = @test_background_color
      ENV["POST_COLOR_1"] =  @test_post_color_1
      ENV["POST_COLOR_2"] = @test_post_color_2
      ENV["POST_COLOR_3"] =  @test_post_color_3
      ENV["POST_COLOR_4"] =  @test_post_color_4
    end

    describe "header link" do
      it "should return a link for user set in env" do
        ENV["HEADER_LINK"] = "MY CUSTOM HEADER"
        expect(EnvironmentService.header_link).to eq(ENV["HEADER_LINK"])
      end

      it "should return #hashtag-anchor if header-link is nil" do
        ENV["HEADER_LINK"] = nil
        expect(EnvironmentService.header_link).to eq("#hashtag-anchor")
      end

      it "should return #hashtag-anchor if header-link is empty" do
        ENV["HEADER_LINK"] = ""
        expect(EnvironmentService.header_link).to eq("#hashtag-anchor")
      end
    end

    describe "twitter credentials" do
      it "should return twitter credentials set in env" do
        ENV["TWITTER_CONSUMER_KEY"] = "key"
        ENV["TWITTER_CONSUMER_SECRET"] = "secret"
        expect(EnvironmentService.twitter_bearer_credentials).to eq(ENV["TWITTER_CONSUMER_KEY"] + ":" + ENV["TWITTER_CONSUMER_SECRET"])
      end

      it "should return nil if twitter key is not set in env" do
        ENV["TWITTER_CONSUMER_KEY"] = nil
        ENV["TWITTER_CONSUMER_SECRET"] = "secret"
        expect(EnvironmentService.twitter_bearer_credentials).to be_nil
      end

      it "should return nil if twitter secret is not set in env" do
        ENV["TWITTER_CONSUMER_KEY"] = "key"
        ENV["TWITTER_CONSUMER_SECRET"] = nil
        expect(EnvironmentService.twitter_bearer_credentials).to be_nil
      end

      it "should return nil if twitter key is an empty string" do
        ENV["TWITTER_CONSUMER_KEY"] = ""
        ENV["TWITTER_CONSUMER_SECRET"] = "secret"
        expect(EnvironmentService.twitter_bearer_credentials).to be_nil
      end

       it "should return nil if twitter secret is an empty string" do
        ENV["TWITTER_CONSUMER_KEY"] = "key"
        ENV["TWITTER_CONSUMER_SECRET"] = ""
        expect(EnvironmentService.twitter_bearer_credentials).to be_nil
      end
    end
    describe "instagram credentials" do
      it "should return twitter credentials set in env" do
        expect(EnvironmentService.instagram_client_id).to eq(ENV["INSTAGRAM_CLIENT_ID"])
      end
      it "should return nil if twitter credentials are not set in env" do
        ENV["INSTAGRAM_CLIENT_ID"] = nil
        expect(EnvironmentService.instagram_client_id).to be_nil
      end
    end

    describe "censored words" do
      it "should return censored words set in env" do
        expect(EnvironmentService.censored_words).to eq(ENV["CENSORED_WORDS"])
      end
      it "should return nil if twitter credentials are not set in env" do
        ENV["CENSORED_WORDS"] = nil
        expect(EnvironmentService.censored_words).to be_nil
      end
    end

    describe "censored users" do
      it "should return censored users set in env" do
        expect(EnvironmentService.censored_users).to eq(ENV["CENSORED_USERS"])
      end
      it "should return nil if twitter credentials are not set in env" do
        ENV["CENSORED_USERS"] = nil
        expect(EnvironmentService.censored_users).to be_nil
      end
    end

    describe "font_family" do
      it "should return what is set in env" do
        ENV["FONT_FAMILY"] = "Comic-Sans"
        expect(EnvironmentService.font_family).to eq("Comic-Sans")
      end
    end

    describe "header_color" do
      it "should return what is set in env" do
        ENV["HEADER_COLOR"] = "#07c"
        expect(EnvironmentService.header_color).to eq("#07c")
      end
    end


    describe "background_color" do
      it "should return what is set in env" do
        ENV["BACKGROUND_COLOR"] = "#07c"
        expect(EnvironmentService.background_color).to eq("#07c")
      end
    end

    describe "post_color_1" do
      it "should return what is set in env" do
        ENV["POST_COLOR_1"] = "#07c"
        expect(EnvironmentService.post_color_1).to eq("#07c")
      end
    end

    describe "post_color_2" do
      it "should return what is set in env" do
        ENV["POST_COLOR_2"] = "#07c"
        expect(EnvironmentService.post_color_2).to eq("#07c")
      end
    end

    describe "post_color_3" do
      it "should return what is set in env" do
        ENV["POST_COLOR_3"] = "#07c"
        expect(EnvironmentService.post_color_3).to eq("#07c")
      end
    end

    describe "post_color_4" do
      it "should return what is set in env" do
        ENV["POST_COLOR_4"] = "#07c"
        expect(EnvironmentService.post_color_4).to eq("#07c")
      end
    end
  end
end
