require 'spec_helper'

module Dashtag
  describe SettingStore do
    it { should validate_presence_of(:name) }

    context "when writing a setting" do
	    it "should dehydrate setting value" do 
        hashtags = Hashtags.new([["peace"], ["love"]])
	    	SettingStore.create_or_update_setting("hashtags", hashtags)
        expect(SettingStore.find_by(name: "hashtags").value).to eq(hashtags.dehydrate)
	    end
	  end
    context "when reading a setting" do
      it "should hydrate setting value" do
        hashtags = Hashtags.new([["peace"], ["love"]])
        SettingStore.create({name: "hashtags", value: hashtags.dehydrate})
        expect(SettingStore.find_setting_or_default("hashtags")).to eq(hashtags)
      end
    end

    describe "Loading Defaults:" do 
      it "should load default for header_title when not set" do
        hashtags = Hashtags.new([["peace"], ["love"]])
        SettingStore.create({name: "hashtags", value: hashtags.dehydrate})
        SettingStore.create({name: "header_title", value: nil})
        
        expect(SettingStore.find_setting_or_default("header_title")).to eq(hashtags.to_ui_format)
      end

      it "should load default for hashtags" do
        expect(SettingStore.find_setting_or_default("hashtags")).to eq(Hashtags.hydrate("[]"))
      end
      it "should load default for twitter_users" do
        expect(SettingStore.find_setting_or_default("twitter_users")).to eq(SocialUsers.hydrate("[]"))
      end
      it "should load default for instagram_users" do
        expect(SettingStore.find_setting_or_default("instagram_users")).to eq(SocialUsers.hydrate("[]"))
      end
      it "should load default for instagram_user_ids" do
        expect(SettingStore.find_setting_or_default("instagram_user_ids")).to eq(InstagramUserIds.hydrate("[]"))
      end
      it "should load default for db_row_limit" do
        expect(SettingStore.find_setting_or_default("db_row_limit")).to eq(NumSetting.hydrate(8000))
      end
      it "should load default for disable_retweets" do
        expect(SettingStore.find_setting_or_default("disable_retweets")).to eq(BoolSetting.hydrate(true))
      end
      it "should load default for header_link" do
        expect(SettingStore.find_setting_or_default("header_link")).to eq(TextSetting.hydrate("#hashtag-anchor"))
      end
      it "should load default for twitter_consumer_key" do
        expect(SettingStore.find_setting_or_default("twitter_consumer_key")).to eq(TextSetting.hydrate(""))
      end
      it "should load default for twitter_consumer_secret" do
        expect(SettingStore.find_setting_or_default("twitter_consumer_secret")).to eq(TextSetting.hydrate(""))
      end
      it "should load default for twitter_consumer_secret" do
        expect(SettingStore.find_setting_or_default("twitter_consumer_secret")).to eq(TextSetting.hydrate(""))
      end
      it "should load default for instagram_client_id" do
        expect(SettingStore.find_setting_or_default("instagram_client_id")).to eq(TextSetting.hydrate(""))
      end
      it "should load default for censored_words" do
        expect(SettingStore.find_setting_or_default("censored_words")).to eq(CensoredWords.hydrate("[]"))
      end
      it "should load default for censored_users" do
        expect(SettingStore.find_setting_or_default("censored_users")).to eq(SocialUsers.hydrate("[]"))
      end
      it "should load default for font_family" do
        expect(SettingStore.find_setting_or_default("font_family")).to eq(TextSetting.hydrate(""))
      end
      it "should load default for header_color" do
        expect(SettingStore.find_setting_or_default("header_color")).to eq(TextSetting.hydrate("#EFEFEF"))
      end
      it "should load default for background_color" do
        expect(SettingStore.find_setting_or_default("background_color")).to eq(TextSetting.hydrate("#EFEFEF"))
      end
      it "should load default for post_color_1" do
        expect(SettingStore.find_setting_or_default("post_color_1")).to eq(TextSetting.hydrate("#B11C54"))
      end
      it "should load default for post_color_2" do
        expect(SettingStore.find_setting_or_default("post_color_2")).to eq(TextSetting.hydrate("#F78F31"))
      end
      it "should load default for post_color_3" do
        expect(SettingStore.find_setting_or_default("post_color_3")).to eq(TextSetting.hydrate("#80C9D2"))
      end
      it "should load default for post_color_4" do
        expect(SettingStore.find_setting_or_default("post_color_4")).to eq(TextSetting.hydrate("#B5B935"))
      end

      describe "api_rate" do
        context "when setting not set" do
          context "and hashtag count is greater than user count" do 
            it "should return 6 * hashtag count" do
              hashtags = Hashtags.parse("#peace, #love & #turtles")
              SettingStore.create({name: "hashtags", value: hashtags.dehydrate})
              SettingStore.create({name: "api_rate", value: nil})
              
              expect(SettingStore.find_setting_or_default("api_rate")).to eq(18)
            end
          end
          context "and user count is greater than hashtag count" do 
            it "should return 6 * user count" do
              SettingStore.create_or_update_setting("twitter_users", SocialUsers.parse("@friends, @enemies"))
              SettingStore.create_or_update_setting("hashtags", Hashtags.parse("#trust"))
              SettingStore.create_or_update_setting("api_rate", nil)
              expect(SettingStore.find_setting_or_default("api_rate")).to eq(12)
            end
          end
        end
      end
    end

    it "should fwd call to SettingStore.{setting name} to SettingStore.find_setting_or_default" do
      SettingStore.create_or_update_setting("header_title", TextSetting.parse("my feed"))
      expect(SettingStore.header_title).to eq(TextSetting.hydrate("my feed"))
    end
    it "should return twitter_bearer_credentials" do
      SettingStore.create_or_update_setting("twitter_consumer_key", TextSetting.parse("thisisreal"))
      SettingStore.create_or_update_setting("twitter_consumer_secret", TextSetting.parse("iswear"))
      expect(SettingStore.twitter_bearer_credentials).to eq("thisisreal:iswear")
    end

    it "should return nil for twitter_bearer_credentials if key or secret does not exist" do
      SettingStore.create_or_update_setting("twitter_consumer_key", TextSetting.parse("thisisreal"))
      SettingStore.create_or_update_setting("twitter_consumer_secret", nil)
      expect(SettingStore.twitter_bearer_credentials).to be_nil
    end
  end
end