require 'spec_helper'

module Dashtag
  describe SettingStore do

    it { should validate_length_of(:header_title).is_at_most(50) }
    it { should validate_numericality_of(:api_rate) }
    it { should validate_numericality_of(:db_row_limit) }

    it { should allow_value('http://foo.com').for(:header_link)}
    it { should allow_value('http://bar.com/baz').for(:header_link)}
    it "should allow default value for header_link" do 
      should allow_value("#hashtag-anchor").for(:header_link)
    end
    it { should_not allow_value('fiz').for(:header_link) }
    it { should_not allow_value('buz').for(:header_link) }
    it { should_not allow_value('bar').for(:header_link) }

    it { should allow_value("bad, words").for(:censored_words) }
    it { should_not allow_value("bad words").for(:censored_words) }
    it { should_not allow_value("bad; words").for(:censored_words) }

    it { should allow_value("@follow, @me").for(:censored_users) }
    it { should_not allow_value("@follow, me").for(:censored_users) }
    it { should_not allow_value("@follow * @me").for(:censored_users) }
    it { should_not allow_value("@follow @me").for(:censored_users) }
    it { should_not allow_value("something").for(:censored_users) }

    it { should allow_value("@follow, @me").for(:twitter_users) }
    it { should_not allow_value("@follow, me").for(:twitter_users) }
    it { should_not allow_value("@follow * @me").for(:twitter_users) }
    it { should_not allow_value("@follow @me").for(:twitter_users) }
    it { should_not allow_value("something").for(:twitter_users) }

    it { should allow_value("1, 38, 4").for(:instagram_user_ids) }
    it { should allow_value("1").for(:instagram_user_ids) }
    it { should_not allow_value("1.4").for(:instagram_user_ids) }
    it { should_not allow_value("-1").for(:instagram_user_ids) }
    it { should_not allow_value("0").for(:instagram_user_ids) }
    it { should_not allow_value("a").for(:instagram_user_ids) }

    it { should allow_value("@follow, @me").for(:instagram_users) }
    it { should_not allow_value("@follow, me").for(:instagram_users) }
    it { should_not allow_value("@follow * @me").for(:instagram_users) }
    it { should_not allow_value("@follow @me").for(:instagram_users) }
    it { should_not allow_value("something").for(:instagram_users) }

    it { should allow_value("#things, #look, #good").for(:hashtags) }
    it { should allow_value("#things, #look & #good").for(:hashtags) }
    it { should_not allow_value("#things, #look, bad").for(:hashtags) }
    it { should_not allow_value("#things, #look, & #bad").for(:hashtags) }
    it { should_not allow_value("#things, #look,       & #bad").for(:hashtags) }
    it { should_not allow_value("#things, #look * #bad").for(:hashtags) }
    it { should_not allow_value("#things, #look, * #bad").for(:hashtags) }
    it { should_not allow_value("#things #look #bad").for(:hashtags) }
    it { should_not allow_value("something").for(:hashtags) }


    it "translates a successful store properly" do
      setting = SettingStore.new(header_title: "best dashtag ever")
      setting.store
      expect(SettingStore.find_by(name: "header_title").value).to eq("best dashtag ever")
    end

    it "produces error properly when fails validation" do
      invalid_title = "h" * 51
      setting = SettingStore.new(header_title: invalid_title)
      expect(setting.valid?).to be_falsy
      expect(setting.errors.messages).to include(:header_title)
    end

    it "does not store invalid settings" do 
      invalid_title = "h" * 51
      setting = SettingStore.new(header_title: invalid_title)
      setting.store
      expect(SettingStore.find_by(name: "header_title")).to be_nil
    end

    context "when writing a setting" do
	    it "should store setting value as string" do
	    	setting_store = SettingStore.new({hashtags: "#peace, #love"})
        setting_store.store
        expect(SettingStore.find_by(name: "hashtags").value).to eq("#peace, #love")
	    end
	  end
    context "when reading hashtags" do
      it "should return value as Hashtags" do
        hashtags = Hashtags.new([["peace"], ["love"]])
        setting_store = SettingStore.new({hashtags: "#peace, #love"})
        setting_store.store
        expect(SettingStore.find_setting_or_default("hashtags")).to eq(hashtags)
      end
    end

    describe "Loading Defaults:" do
      it "should load default for header_title when not set" do
        SettingStore.new(hashtags: "#peace & #love", header_title: nil).store
        expect(SettingStore.header_title).to eq("#peace & #love")
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
          context "and no hashtags, or users are in the system" do
            it "should return 15" do
              expect(SettingStore.find_setting_or_default("api_rate")).to eq(15)
            end
          end
          context "and hashtag count is greater than user count" do 
            it "should return 6 * hashtag count" do
              SettingStore.new(twitter_users: "@friends, @enemies", hashtags: "#peace, #love & #turtles", api_rate: nil).store
              expect(SettingStore.find_setting_or_default("api_rate")).to eq(18)
            end
          end
          context "and user count is greater than hashtag count" do 
            it "should return 6 * user count" do
              SettingStore.new(twitter_users: "@friends, @enemies", hashtags: "#trust", api_rate: nil).store
              expect(SettingStore.find_setting_or_default("api_rate")).to eq(12)
            end
          end
        end
      end
    end

    it "should fwd call to SettingStore.{setting name} to SettingStore.find_setting_or_default" do
      SettingStore.new(header_title: "my feed").store
      expect(SettingStore.header_title).to eq(TextSetting.hydrate("my feed"))
    end
    it "should return twitter_bearer_credentials" do
      SettingStore.new(twitter_consumer_key: "thisisreal").store
      SettingStore.new(twitter_consumer_secret: "iswear").store
      expect(SettingStore.twitter_bearer_credentials).to eq("thisisreal:iswear")
    end

    it "should return nil for twitter_bearer_credentials if key or secret does not exist" do
      SettingStore.new(twitter_consumer_key: "thisisreal").store
      SettingStore.new(twitter_consumer_secret: nil).store
      expect(SettingStore.twitter_bearer_credentials).to be_nil
    end
  end
end