require 'spec_helper'

module Dashtag
  describe Settings do
    it { should validate_presence_of(:hashtags) }
    it { should validate_numericality_of(:api_rate) }
    it { should allow_value("#things, #look, #good").for(:hashtags) }
    it { should allow_value("#things, #look & #good").for(:hashtags) }
    it { should_not allow_value("#things, #look, bad").for(:hashtags) }
    it { should_not allow_value("#things, #look, & #bad").for(:hashtags) }
    it { should_not allow_value("#things, #look,       & #bad").for(:hashtags) }
    it { should_not allow_value("#things, #look * #bad").for(:hashtags) }
    it { should_not allow_value("#things, #look, * #bad").for(:hashtags) }
    it { should_not allow_value("#things #look #bad").for(:hashtags) }
    it { should_not allow_value("something").for(:hashtags) }

    it { should allow_value("@follow, @me").for(:twitter_users) }
    it { should_not allow_value("@follow, me").for(:twitter_users) }
    it { should_not allow_value("@follow * @me").for(:twitter_users) }
    it { should_not allow_value("@follow @me").for(:twitter_users) }
    it { should_not allow_value("something").for(:twitter_users) }

    it { should allow_value("@follow, @me").for(:instagram_users) }
    it { should_not allow_value("@follow, me").for(:instagram_users) }
    it { should_not allow_value("@follow * @me").for(:instagram_users) }
    it { should_not allow_value("@follow @me").for(:instagram_users) }
    it { should_not allow_value("something").for(:instagram_users) }
    
    it { should allow_value("1, 38, 4").for(:instagram_user_ids) }
    it { should allow_value("1").for(:instagram_user_ids) }
    it { should_not allow_value("1.4").for(:instagram_user_ids) }
    it { should_not allow_value("-1").for(:instagram_user_ids) }
    it { should_not allow_value("0").for(:instagram_user_ids) }
    it { should_not allow_value("a").for(:instagram_user_ids) }

    let(:settings) {FactoryGirl.build(:settings) }

    context "when settings are not set in db" do
      it "should load default" do
        expect(Settings.load_settings.hashtags).to eq("")
      end
    end
  
    context "when settings are valid" do
      before(:each) {Settings.new(hashtags: "#peace, #love").store}
  	  
      it "should update hashtags" do
  	    expect(Settings.load_settings.hashtags).to eq("#peace, #love")
  	  end

      it "should update header_title" do
        settings.header_title = "hi there"
        settings.store
        expect(Settings.load_settings.header_title).to eq("hi there")
      end

      it "should update api_rate" do
        settings.api_rate = 10
        settings.store
        expect(Settings.load_settings.api_rate).to eq(10)
      end

      it "should store nil values (for nullable settings)" do
        settings.hashtags = "#peace, #love"
        settings.header_title = nil
        settings.store
        expect(Settings.load_settings.header_title).to eq("#peace, #love")
      end

      it "should update twitter_users" do
        settings.twitter_users = "@yolo, @dance, @christmas"
        settings.store
        expect(Settings.load_settings.twitter_users).to eq("@yolo, @dance, @christmas")
      end

      it "should update instagram_users" do
        settings.instagram_users = "@yolo, @dance, @christmas"
        settings.store
        expect(Settings.load_settings.instagram_users).to eq("@yolo, @dance, @christmas")
      end

      it "should update instagram_user_ids" do
        settings.instagram_user_ids = "12345, 2345345345, 1235345"
        settings.store
        expect(Settings.load_settings.instagram_user_ids).to eq("12345, 2345345345, 1235345")
      end

      it "should update db_row_limit" do 
        settings.db_row_limit = "1000"
        settings.store
        expect(Settings.load_settings.db_row_limit).to eq(1000)
      end

      it "should update disable_retweets" do
        settings.disable_retweets = "0"
        settings.store
        expect(Settings.load_settings.disable_retweets).to eq(false)
        settings.disable_retweets = "1"
        settings.store
        expect(Settings.load_settings.disable_retweets).to eq(true)
      end

      it "should update header_link" do
        settings.header_link = "http://www.example.com"
        settings.store
        expect(Settings.load_settings.header_link).to eq("http://www.example.com")
      end

      it "should update twitter_consumer_key" do
        settings.twitter_consumer_key = "thisisaconsumerkey"
        settings.store
        expect(Settings.load_settings.twitter_consumer_key).to eq("thisisaconsumerkey")
      end

      it "should update twitter_consumer_secret" do
        settings.twitter_consumer_secret = "thisisaconsumersecret"
        settings.store
        expect(Settings.load_settings.twitter_consumer_secret).to eq("thisisaconsumersecret")
      end

      it "should update instagram_client_id" do
        settings.instagram_client_id = "instagram_client_id"
        settings.store
        expect(Settings.load_settings.instagram_client_id).to eq("instagram_client_id")
      end

      it "should update censored_words" do
        settings.censored_words = "censored, words"
        settings.store
        expect(Settings.load_settings.censored_words).to eq("censored, words")
      end

      it "should update censored_users" do
        settings.censored_users = "@big, @brother"
        settings.store
        expect(Settings.load_settings.censored_users).to eq("@big, @brother")
      end

      it "should update font_family" do
        settings.font_family = "Times New Roman"
        settings.store
        expect(Settings.load_settings.font_family).to eq("Times New Roman")
      end

      it "should update header_color" do
        settings.header_color = "#FF0000"
        settings.store
        expect(Settings.load_settings.header_color).to eq("#FF0000")
      end

      it "should update background_color" do
        settings.background_color = "#FF0000"
        settings.store
        expect(Settings.load_settings.background_color).to eq("#FF0000")
      end

      it "should update post_color_1" do
        settings.post_color_1 = "#FF0000"
        settings.store
        expect(Settings.load_settings.post_color_1).to eq("#FF0000")
      end

      it "should update post_color_2" do
        settings.post_color_2 = "#FF0000"
        settings.store
        expect(Settings.load_settings.post_color_2).to eq("#FF0000")
      end

      it "should update post_color_3" do
        settings.post_color_3 = "#FF0000"
        settings.store
        expect(Settings.load_settings.post_color_3).to eq("#FF0000")
      end

      it "should update post_color_4" do
        settings.post_color_4 = "#FF0000"
        settings.store
        expect(Settings.load_settings.post_color_4).to eq("#FF0000")
      end
    end
  end
end