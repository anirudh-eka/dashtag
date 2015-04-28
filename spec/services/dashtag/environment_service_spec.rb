require 'spec_helper'

module Dashtag
  describe EnvironmentService do
    before(:each) do 
      @default_key = ENV["TWITTER_BEARER_KEY"]
      @default_secret = ENV["TWITTER_BEARER_SECRET"]
      @default_header_title = ENV["HEADER_TITLE"]
      @default_twitter_users = ENV["TWITTER_USERS"]
      @default_instagram_user_id = ENV["INSTAGRAM_USER_IDS"]
      @default_instagram_users = ENV["INSTAGRAM_USERS"]
      @default_header_link = ENV["HEADER_LINK"]
      @default_hashtags = ENV["HASHTAGS"]
      @default_censored_words = ENV["CENSORED_WORDS"]
      @default_instagram_client_id = ENV["INSTAGRAM_CLIENT_ID"]
      @default_censored_users = ENV["CENSORED_USERS"]
      @test_disable_retweets = ENV["DISABLE_RETWEETS"]
      @test_db_row_limit = ENV["DB_ROW_LIMIT"]
      @test_ajax_interval = ENV["AJAX_INTERVAL"] 
      @test_api_rate = ENV["API_RATE"] 
      @test_font_family = ENV["FONT_FAMILY"]
      @test_header_color = ENV["HEADER_COLOR"]
      @test_background_color = ENV["BACKGROUND_COLOR"]
      @test_post_color_1 = ENV["POST_COLOR_1"]
      @test_post_color_2 = ENV["POST_COLOR_2"]
      @test_post_color_3 = ENV["POST_COLOR_3"]
      @test_post_color_4 = ENV["POST_COLOR_4"]
    end

    after(:each) do 
      ENV["TWITTER_BEARER_KEY"] = @default_key
      ENV["TWITTER_BEARER_SECRET"] = @default_secret
      ENV["HEADER_TITLE"] = @default_header_title
      ENV["TWITTER_USERS"] = @default_twitter_users
      ENV["INSTAGRAM_USER_IDS"] = @default_instagram_user_id
      ENV["INSTAGRAM_USERS"] =  @default_instagram_users
      ENV["HEADER_LINK"] =  @default_header_link
      ENV["HASHTAGS"] =  @default_hashtags
      ENV["CENSORED_WORDS"] = @default_censored_words
      ENV["INSTAGRAM_CLIENT_ID"] = @default_instagram_client_id
      ENV["CENSORED_USERS"] = @default_censored_users 
      ENV["DISABLE_RETWEETS"] = @test_disable_retweets
      ENV["DB_ROW_LIMIT"] =  @test_db_row_limit
      ENV["AJAX_INTERVAL"] =  @test_ajax_interval
      ENV["API_RATE"] =  @test_api_rate
      ENV["FONT_FAMILY"] =  @test_font_family 
      ENV["HEADER_COLOR"] = @test_header_color
      ENV["BACKGROUND_COLOR"] = @test_background_color
      ENV["POST_COLOR_1"] =  @test_post_color_1
      ENV["POST_COLOR_2"] = @test_post_color_2
      ENV["POST_COLOR_3"] =  @test_post_color_3
      ENV["POST_COLOR_4"] =  @test_post_color_4
    end

    describe "header title" do
      def header_title_helper_for(env_title_value)
        default_title = "##{EnvironmentService.hashtag_array.join(" #")}"
        ENV["HEADER_TITLE"] = env_title_value
        expect(EnvironmentService.header_title).to eq(default_title)
      end

      it "should return a title for user set in env with '#'" do
        ENV["HEADER_TITLE"] = "something"
        expect(EnvironmentService.header_title).to eq("#{ENV["HEADER_TITLE"]}")
      end

      it "should return string of hashtags if title is nil" do
        header_title_helper_for(nil)
      end
      it "should return string of hashtags if title is empty" do
        header_title_helper_for("")
      end
    end

    describe "twitter_users" do
      it 'should parse EnvironmentService.twitter_users into an array' do
        ENV["TWITTER_USERS"] = "yolo|dance|christmas"
        expected_array = ['yolo', 'dance', 'christmas']
        expect(EnvironmentService.twitter_users).to eq(expected_array)
      end

      it "should return an empty array if twitter_users are not set in env" do
        ENV["TWITTER_USERS"] = nil
        expect(EnvironmentService.twitter_users).to be_empty
      end

      it "should return an empty array if twitter_users are not set in env" do
        ENV["TWITTER_USERS"] = ""
        expect(EnvironmentService.twitter_users).to be_empty
      end
    end

    describe "instagram_user_ids" do
      it 'should parse EnvironmentService.instagram_user_ids into an array' do
        ENV["INSTAGRAM_USER_IDS"] = "12345|2345345345|1235345"
        expected_array = ['12345', '2345345345', '1235345']
        expect(EnvironmentService.instagram_user_ids).to eq(expected_array)
      end

      it "should return an empty array if instagram_user_ids are not set in env" do
        ENV["INSTAGRAM_USER_IDS"] = nil
        expect(EnvironmentService.instagram_user_ids).to be_empty
      end

      it "should return an empty array if instagram_user_ids are not set in env" do
        ENV["INSTAGRAM_USER_IDS"] = ""
        expect(EnvironmentService.instagram_user_ids).to be_empty
      end
    end

    describe "instagram_users" do
      it 'should parse EnvironmentService.instagram_users into an array' do
        ENV["INSTAGRAM_USERS"] = "kingjames|trey5"
        expected_array = ['kingjames', 'trey5']
        expect(EnvironmentService.instagram_users).to eq(expected_array)
      end

      it "should return an empty array if instagram_users are not set in env" do
        ENV["INSTAGRAM_USERS"] = nil
        expect(EnvironmentService.instagram_users).to be_empty
      end

      it "should return an empty array if instagram_users are not set in env" do
        ENV["INSTAGRAM_USERS"] = ""
        expect(EnvironmentService.instagram_users).to be_empty
      end
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



    describe "hashtags" do
      it "should return an empty array if HASHTAGS and HASHTAG have a nil value" do
        ENV["HASHTAGS"] = nil
        ENV["HASHTAG"] = nil
        expect(EnvironmentService.hashtag_array).to be_empty
      end

      it "should return an empty array if HASHTAGS and HASHTAG have an empty string value" do
        ENV["HASHTAGS"] = ""
        ENV["HASHTAG"] = ""
        expect(EnvironmentService.hashtag_array).to be_empty
      end

      it 'should parse EnvironmentService.hashtag into an array' do
        ENV["HASHTAGS"] = "yolo|dance|christmas"
        expected_array = ['yolo', 'dance', 'christmas']
        expect(EnvironmentService.hashtag_array).to eq(expected_array)
      end

      it "should provide backwards support for apps that set the env variable as 'hashtag' and not using 'hashtags'" do
        ENV["HASHTAG"] = "yolo"
        ENV["HASHTAGS"] = nil
        expected_array = ['yolo']
        expect(EnvironmentService.hashtag_array).to eq(expected_array)
      end

      it "should strip non-essential white space off hashtags" do
        ENV["HASHTAGS"] = "\nyolo|cool|stuff\n\n"
        expect(EnvironmentService.hashtag_array).to eq(%w(yolo cool stuff))
      end

      context "if HASHTAG and HASHTAGS variable are set in environment" do
        it "should use HASHTAGS" do
          ENV["HASHTAG"] = "love"
          ENV["HASHTAGS"] = "yolo|dance|christmas"
          expected_array = ['yolo', 'dance', 'christmas']
          expect(EnvironmentService.hashtag_array).to eq(expected_array)
        end
      end
    end

    describe "twitter credentials" do
      it "should return twitter credentials set in env" do
        ENV["TWITTER_BEARER_KEY"] = "key"
        ENV["TWITTER_BEARER_SECRET"] = "secret"
        expect(EnvironmentService.twitter_bearer_credentials).to eq(ENV["TWITTER_BEARER_KEY"] + ":" + ENV["TWITTER_BEARER_SECRET"])
      end

      it "should return nil if twitter key is not set in env" do
        ENV["TWITTER_BEARER_KEY"] = nil
        ENV["TWITTER_BEARER_SECRET"] = "secret"
        expect(EnvironmentService.twitter_bearer_credentials).to be_nil
      end

      it "should return nil if twitter secret is not set in env" do 
        ENV["TWITTER_BEARER_KEY"] = "key" 
        ENV["TWITTER_BEARER_SECRET"] = nil
        expect(EnvironmentService.twitter_bearer_credentials).to be_nil
      end 

      it "should return nil if twitter key is an empty string" do 
        ENV["TWITTER_BEARER_KEY"] = ""
        ENV["TWITTER_BEARER_SECRET"] = "secret"
        expect(EnvironmentService.twitter_bearer_credentials).to be_nil
      end 

       it "should return nil if twitter secret is an empty string" do 
        ENV["TWITTER_BEARER_KEY"] = "key"
        ENV["TWITTER_BEARER_SECRET"] = ""
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

    describe "disable retweets" do
      it "should return what is set in env in downcase" do
        ENV["DISABLE_RETWEETS"] = "fAlSe"
        expect(EnvironmentService.disable_retweets).to eq(false)
      end

      it "should return true by default" do
        ENV["DISABLE_RETWEETS"] = nil
        expect(EnvironmentService.disable_retweets).to eq(true)
      end
    end

    describe "api_rate" do
      it "should return what is set in env" do
        ENV["API_RATE"] = "10"
        expect(EnvironmentService.api_rate).to eq(10)
      end

      it "should return 6 * hashtag count by default and hashtag count is greater than user count" do
        hashtag_count = EnvironmentService.hashtag_array.count
        ENV["API_RATE"] = nil
        expect(EnvironmentService.api_rate).to eq(6 * hashtag_count)
      end

      it "should return 6 * hashtag count if entry is not integer and hashtag count is greater than user count" do
        hashtag_count = EnvironmentService.hashtag_array.count
        ENV["API_RATE"] = "stuff"
        expect(EnvironmentService.api_rate).to eq(6 * hashtag_count)
      end

      it "should return 6 * users count if entry is not integer and users count is greater than hashtag count" do
        ENV["TWITTER_USERS"] = "my|screen|name|4th_user|g3"
        users_count = EnvironmentService.twitter_users.count
        ENV["API_RATE"] = "stuff"
        expect(EnvironmentService.api_rate).to eq(6 * users_count)
      end
    end


    describe "ajax_interval" do
      it "should return what is set in env" do
        ENV["AJAX_INTERVAL"] = "1000"
        expect(EnvironmentService.ajax_interval).to eq(1000)
      end

      it "should return 5000 by default" do
        ENV["AJAX_INTERVAL"] = nil
        expect(EnvironmentService.ajax_interval).to eq(5000)
      end

      it "should return 5000 if entry is not integer" do
        ENV["AJAX_INTERVAL"] = "stuff"
        expect(EnvironmentService.ajax_interval).to eq(5000)
      end
    end

    describe "db_row_limit" do
      it "should return what is set in env" do
        ENV["DB_ROW_LIMIT"] = "3000"
        expect(EnvironmentService.db_row_limit).to eq(3000)
      end

      it "should return 8000 by default" do
        ENV["DB_ROW_LIMIT"] = nil
        expect(EnvironmentService.db_row_limit).to eq(8000)
      end


      it "should return 8000 if entry is not integer" do
        ENV["DB_ROW_LIMIT"] = "stuff"
        expect(EnvironmentService.db_row_limit).to eq(8000)
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
