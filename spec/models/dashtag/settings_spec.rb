require 'spec_helper'

module Dashtag
  describe Settings do
    describe "non conditional validation" do

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
    end

    describe "validation conditional on api keys filled out" do
      context "if twitter_consumer_key is set" do
        before { subject.stub(:twitter_consumer_key) { "twitter_consumer_key" } }
        it { should validate_presence_of(:twitter_consumer_secret) }
      end
      context "if twitter_consumer_key is not set" do
        before { subject.stub(:twitter_consumer_key) { "" } }
        it { should_not validate_presence_of(:twitter_consumer_secret) }
      end
      context "if twitter_consumer_secret is set" do
        before { subject.stub(:twitter_consumer_secret) { "twitter_consumer_secret" } }
        it { should validate_presence_of(:twitter_consumer_key) }
      end
      context "if twitter_consumer_secret is not set" do
        before { subject.stub(:twitter_consumer_secret) { "" } }
        it { should_not validate_presence_of(:twitter_consumer_key) }
      end

      describe "setting twitter_users" do
        context "if either twitter_consumer_key, twitter_consumer_secret or neither are set" do
          [:twitter_consumer_key, :twitter_consumer_secret, nil].each do |api_key|
            before {subject.stub(api_key)} unless api_key.nil?
            it { should validate_absence_of(:twitter_users).with_message("posts cannot be pulled by Twitter users without a Twitter consumer key and secret, please fill them in") }
          end
        end
        context "if both twitter_consumer_key and twitter_consumer_secret are set" do 
          before { subject.stub(:twitter_consumer_key) { "key"}}
          before { subject.stub(:twitter_consumer_secret) { "secret"}}
          it { should allow_value("@follow, @me").for(:twitter_users) }
          it { should_not allow_value("@follow, me").for(:twitter_users) }
          it { should_not allow_value("@follow * @me").for(:twitter_users) }
          it { should_not allow_value("@follow @me").for(:twitter_users) }
          it { should_not allow_value("something").for(:twitter_users) }
        end
      end

      describe "setting instagram_user_ids" do
        context "if instagram_client_id is not set" do
          before { subject.stub(:instagram_client_id) {""} }
          it { should validate_absence_of(:instagram_user_ids).with_message("posts cannot be pulled by Instagram user IDs without an Instagram client ID, please fill it in") }
        end
        context "if instagram_client_id is set" do
          before { subject.stub(:instagram_client_id) {"instagram_client_id"} }
            it { should allow_value("1, 38, 4").for(:instagram_user_ids) }
            it { should allow_value("1").for(:instagram_user_ids) }
            it { should_not allow_value("1.4").for(:instagram_user_ids) }
            it { should_not allow_value("-1").for(:instagram_user_ids) }
            it { should_not allow_value("0").for(:instagram_user_ids) }
            it { should_not allow_value("a").for(:instagram_user_ids) }
        end
      end

      describe "setting instagram_users" do
        context "if instagram_client_id is not set" do
          before { subject.stub(:instagram_client_id) {""} }
          it { should validate_absence_of(:instagram_users).with_message("posts cannot be pulled by Instagram users without an Instagram client ID, please fill it in") }
        end
        context "if instagram_client_id is set" do
          before { subject.stub(:instagram_client_id) {"instagram_client_id"} }
          it { should allow_value("@follow, @me").for(:instagram_users) }
          it { should_not allow_value("@follow, me").for(:instagram_users) }
          it { should_not allow_value("@follow * @me").for(:instagram_users) }
          it { should_not allow_value("@follow @me").for(:instagram_users) }
          it { should_not allow_value("something").for(:instagram_users) }
        end
      end

      describe "setting hashtags" do 
        context "if instagram_client_id, and twitter_consumer_key and/or twitter_consumer_secret are not set" do
          [:instagram_client_id, :twitter_consumer_secret, :twitter_consumer_key].each do |api_key|
            before { subject.stub(api_key) {""} }
            it { should validate_absence_of(:hashtags).with_message("posts cannot be pulled by hashtags without an Instagram client ID or twitter consumer key and secret, please fill them in")}
          end
        end  

        context "when only instagram_client_id is included" do
          before(:each) {subject.stub(:instagram_client_id) {"something"}}
          it { should allow_value("#things, #look, #good").for(:hashtags) }
          it { should allow_value("#things, #look & #good").for(:hashtags) }
          it { should_not allow_value("#things, #look, bad").for(:hashtags) }
          it { should_not allow_value("#things, #look, & #bad").for(:hashtags) }
          it { should_not allow_value("#things, #look,       & #bad").for(:hashtags) }
          it { should_not allow_value("#things, #look * #bad").for(:hashtags) }
          it { should_not allow_value("#things, #look, * #bad").for(:hashtags) }
          it { should_not allow_value("#things #look #bad").for(:hashtags) }
          it { should_not allow_value("something").for(:hashtags) }
        end

        context "when only twitter_consumer_key/secret is included" do
          before(:each) { subject.stub(:twitter_consumer_key) { "key"}}
          before(:each) { subject.stub(:twitter_consumer_secret) { "secret"}}
          [:twitter_consumer_secret, :twitter_consumer_key].each do |api_key|
            before { subject.stub(api_key) {""} }
            it { should validate_absence_of(:hashtags).with_message("posts cannot be pulled by hashtags without an Instagram client ID or twitter consumer key and secret, please fill them in")}  
          end
        end  
      end
    end

    let(:settings) {FactoryGirl.build(:settings) }

    context "when settings are not set in db" do
      it "should load default" do
        expect(Settings.load_settings.hashtags).to eq("")
      end
    end
  
    context "when settings are valid" do
      it "should update hashtags" do
        settings.instagram_client_id = "instagram_client_id"
        settings.hashtags = "#peace, #love"
        settings.store
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
        settings.instagram_client_id = "instagram_client_id"
        settings.hashtags = "#peace, #love"
        settings.header_title = nil
        settings.store
        expect(Settings.load_settings.header_title).to eq("#peace, #love")
      end

      it "should update twitter_users" do
        settings.twitter_consumer_secret = "secret"
        settings.twitter_consumer_key = "key"
        settings.twitter_users = "@yolo, @dance, @christmas"
        settings.store
        expect(Settings.load_settings.twitter_users).to eq("@yolo, @dance, @christmas")
      end

      it "should update instagram_users" do
        settings.instagram_client_id = "instagram_client_id"
        settings.instagram_users = "@yolo, @dance, @christmas"
        settings.store
        expect(Settings.load_settings.instagram_users).to eq("@yolo, @dance, @christmas")
      end

      it "should update instagram_user_ids" do
        settings.instagram_client_id = "instagram_client_id"
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

      it "should update twitter_consumer_key & twitter_consumer_secret" do
        settings.twitter_consumer_key = "thisisaconsumerkey"
        settings.twitter_consumer_secret = "thisisaconsumersecret"
        settings.store
        expect(Settings.load_settings.twitter_consumer_key).to eq("thisisaconsumerkey")
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