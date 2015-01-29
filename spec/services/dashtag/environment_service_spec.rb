require 'spec_helper'

module Dashtag
  describe EnvironmentService do
    describe "header title" do
      def header_title_helper_for(env_title_value)
        default_val = ENV["HEADER_TITLE"]
        default_title = "##{EnvironmentService.hashtag_array.join(" #")}"
        ENV["HEADER_TITLE"] = env_title_value
        expect(EnvironmentService.header_title).to eq(default_title)
        ENV["HEADER_TITLE"] = default_val
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
        default_val = ENV["TWITTER_USERS"]
        ENV["TWITTER_USERS"] = "yolo|dance|christmas"
        expected_array = ['yolo', 'dance', 'christmas']
        expect(EnvironmentService.twitter_users).to eq(expected_array)
        ENV["TWITTER_USERS"] = default_val
      end

      it "should return an empty array if twitter_users are not set in env" do
        default_cred = ENV["TWITTER_USERS"]
        ENV["TWITTER_USERS"] = nil
        expect(EnvironmentService.twitter_users).to be_empty
        ENV["TWITTER_USERS"] = default_cred
      end

      it "should return an empty array if twitter_users are not set in env" do
        default_cred = ENV["TWITTER_USERS"]
        ENV["TWITTER_USERS"] = ""
        expect(EnvironmentService.twitter_users).to be_empty
        ENV["TWITTER_USERS"] = default_cred
      end
    end

    describe "instagram_user_ids" do
      it 'should parse EnvironmentService.instagram_user_ids into an array' do
        default_val = ENV["INSTAGRAM_USER_IDS"]
        ENV["INSTAGRAM_USER_IDS"] = "12345|2345345345|1235345"
        expected_array = ['12345', '2345345345', '1235345']
        expect(EnvironmentService.instagram_user_ids).to eq(expected_array)
        ENV["INSTAGRAM_USER_IDS"] = default_val
      end

      it "should return an empty array if instagram_user_ids are not set in env" do
        default_cred = ENV["INSTAGRAM_USER_IDS"]
        ENV["INSTAGRAM_USER_IDS"] = nil
        expect(EnvironmentService.instagram_user_ids).to be_empty
        ENV["INSTAGRAM_USER_IDS"] = default_cred
      end

      it "should return an empty array if instagram_user_ids are not set in env" do
        default_cred = ENV["INSTAGRAM_USER_IDS"]
        ENV["INSTAGRAM_USER_IDS"] = ""
        expect(EnvironmentService.instagram_user_ids).to be_empty
        ENV["INSTAGRAM_USER_IDS"] = default_cred
      end
    end

    describe "instagram_users" do
      it 'should parse EnvironmentService.instagram_users into an array' do
        default_val = ENV["INSTAGRAM_USERS"]
        ENV["INSTAGRAM_USERS"] = "kingjames|trey5"
        expected_array = ['kingjames', 'trey5']
        expect(EnvironmentService.instagram_users).to eq(expected_array)
        ENV["INSTAGRAM_USERS"] = default_val
      end

      it "should return an empty array if instagram_users are not set in env" do
        default_cred = ENV["INSTAGRAM_USERS"]
        ENV["INSTAGRAM_USERS"] = nil
        expect(EnvironmentService.instagram_users).to be_empty
        ENV["INSTAGRAM_USERS"] = default_cred
      end

      it "should return an empty array if instagram_users are not set in env" do
        default_cred = ENV["INSTAGRAM_USERS"]
        ENV["INSTAGRAM_USERS"] = ""
        expect(EnvironmentService.instagram_users).to be_empty
        ENV["INSTAGRAM_USERS"] = default_cred
      end
    end

    describe "header link" do
      it "should return a link for user set in env" do
        default_val = ENV["HEADER_LINK"]
        ENV["HEADER_LINK"] = "MY CUSTOM HEADER"
        expect(EnvironmentService.header_link).to eq(ENV["HEADER_LINK"])
        ENV["HEADER_LINK"] = default_val
      end

      it "should return #hashtag-anchor if header-link is nil" do
        default_val = ENV["HEADER_LINK"]
        ENV["HEADER_LINK"] = nil
        expect(EnvironmentService.header_link).to eq("#hashtag-anchor")
        ENV["HEADER_LINK"] = default_val
      end

      it "should return #hashtag-anchor if header-link is empty" do
        default_val = ENV["HEADER_LINK"]
        ENV["HEADER_LINK"] = ""
        expect(EnvironmentService.header_link).to eq("#hashtag-anchor")
        ENV["HEADER_LINK"] = default_val
      end
    end



    describe "hashtags" do
      it "should return an empty array if HASHTAGS and HASHTAG have a nil value" do
        default_val = ENV["HASHTAGS"]
        ENV["HASHTAGS"] = nil
        ENV["HASHTAG"] = nil
        expect(EnvironmentService.hashtag_array).to be_empty
        ENV["HASHTAGS"] = default_val
      end

      it "should return an empty array if HASHTAGS and HASHTAG have an empty string value" do
        default_val = ENV["HASHTAGS"]
        ENV["HASHTAGS"] = ""
        ENV["HASHTAG"] = ""
        expect(EnvironmentService.hashtag_array).to be_empty
        ENV["HASHTAGS"] = default_val
      end

      it 'should parse EnvironmentService.hashtag into an array' do
        default_val = ENV["HASHTAGS"]
        ENV["HASHTAGS"] = "yolo|dance|christmas"
        expected_array = ['yolo', 'dance', 'christmas']
        expect(EnvironmentService.hashtag_array).to eq(expected_array)
        ENV["HASHTAGS"] = default_val
      end

      it "should provide backwards support for apps that set the env variable as 'hashtag' and not using 'hashtags'" do
        default_val = ENV["HASHTAG"]
        ENV["HASHTAG"] = "yolo"
        ENV["HASHTAGS"] = nil
        expected_array = ['yolo']
        expect(EnvironmentService.hashtag_array).to eq(expected_array)
        ENV["HASHTAG"] = default_val
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
        expect(EnvironmentService.twitter_bearer_credentials).to eq(ENV["TWITTER_BEARER_CREDENTIALS"])
      end

      it "should return nil if twitter credentials are not set in env" do
        default_cred = ENV["TWITTER_BEARER_CREDENTIALS"]
        ENV["TWITTER_BEARER_CREDENTIALS"] = nil
        expect(EnvironmentService.twitter_bearer_credentials).to be_nil
        ENV["TWITTER_BEARER_CREDENTIALS"] = default_cred
      end
    end
    describe "instagram credentials" do
      it "should return twitter credentials set in env" do
        expect(EnvironmentService.instagram_client_id).to eq(ENV["INSTAGRAM_CLIENT_ID"])
      end
      it "should return nil if twitter credentials are not set in env" do
        default_cred = ENV["INSTAGRAM_CLIENT_ID"]
        ENV["INSTAGRAM_CLIENT_ID"] = nil
        expect(EnvironmentService.instagram_client_id).to be_nil
        ENV["INSTAGRAM_CLIENT_ID"] = default_cred
      end
    end

    describe "censored words" do
      it "should return censored words set in env" do
        expect(EnvironmentService.censored_words).to eq(ENV["CENSORED_WORDS"])
      end
      it "should return nil if twitter credentials are not set in env" do
        default_cred = ENV["CENSORED_WORDS"]
        ENV["CENSORED_WORDS"] = nil
        expect(EnvironmentService.censored_words).to be_nil
        ENV["CENSORED_WORDS"] = default_cred
      end
    end

    describe "censored users" do
      it "should return censored users set in env" do
        expect(EnvironmentService.censored_users).to eq(ENV["CENSORED_USERS"])
      end
      it "should return nil if twitter credentials are not set in env" do
        default_cred = ENV["CENSORED_USERS"]
        ENV["CENSORED_USERS"] = nil
        expect(EnvironmentService.censored_users).to be_nil
        ENV["CENSORED_USERS"] = default_cred
      end
    end

    describe "disable retweets" do
      it "should return what is set in env in downcase" do
        test_env = ENV["DISABLE_RETWEETS"]
        ENV["DISABLE_RETWEETS"] = "fAlSe"
        expect(EnvironmentService.disable_retweets).to eq(false)
        ENV["DISABLE_RETWEETS"] = test_env
      end

      it "should return true by default" do
        test_env = ENV["DISABLE_RETWEETS"]
        ENV["DISABLE_RETWEETS"] = nil
        expect(EnvironmentService.disable_retweets).to eq(true)
        ENV["DISABLE_RETWEETS"] = test_env
      end
    end

    describe "api_rate" do
      before(:each) { @test_env = ENV["API_RATE"] }
      after(:each) { ENV["API_RATE"] = @test_env }

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
        test_env = ENV["TWITTER_USERS"]
        ENV["TWITTER_USERS"] = "my|screen|name|4th_user|g3"
        users_count = EnvironmentService.twitter_users.count
        ENV["API_RATE"] = "stuff"
        expect(EnvironmentService.api_rate).to eq(6 * users_count)
        ENV["TWITTER_USERS"] = test_env
      end
    end


    describe "ajax_interval" do
      before(:each){ @test_env = ENV["AJAX_INTERVAL"] }
      after(:each){ ENV["AJAX_INTERVAL"] = @test_env }

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
        test_env = ENV["DB_ROW_LIMIT"]
        ENV["DB_ROW_LIMIT"] = "3000"
        expect(EnvironmentService.db_row_limit).to eq(3000)
        ENV["DB_ROW_LIMIT"] = test_env
      end

      it "should return 8000 by default" do
        test_env = ENV["DB_ROW_LIMIT"]
        ENV["DB_ROW_LIMIT"] = nil
        expect(EnvironmentService.db_row_limit).to eq(8000)
        ENV["DB_ROW_LIMIT"] = test_env
      end


      it "should return 8000 if entry is not integer" do
        test_env = ENV["DB_ROW_LIMIT"]
        ENV["DB_ROW_LIMIT"] = "stuff"
        expect(EnvironmentService.db_row_limit).to eq(8000)
        ENV["DB_ROW_LIMIT"] = test_env
      end
    end

    describe "font_family" do
      it "should return what is set in env" do
        test_env = ENV["FONT_FAMILY"]
        ENV["FONT_FAMILY"] = "Comic-Sans"
        expect(EnvironmentService.font_family).to eq("Comic-Sans")
        ENV["FONT_FAMILY"] = test_env
      end
    end

    describe "header_color" do
      it "should return what is set in env" do
        test_env = ENV["HEADER_COLOR"]
        ENV["HEADER_COLOR"] = "#07c"
        expect(EnvironmentService.header_color).to eq("#07c")
        ENV["HEADER_COLOR"] = test_env
      end
    end


    describe "background_color" do
      it "should return what is set in env" do
        test_env = ENV["BACKGROUND_COLOR"]
        ENV["BACKGROUND_COLOR"] = "#07c"
        expect(EnvironmentService.background_color).to eq("#07c")
        ENV["BACKGROUND_COLOR"] = test_env
      end
    end

    describe "post_color_1" do
      it "should return what is set in env" do
        test_env = ENV["POST_COLOR_1"]
        ENV["POST_COLOR_1"] = "#07c"
        expect(EnvironmentService.post_color_1).to eq("#07c")
        ENV["POST_COLOR_1"] = test_env
      end
    end

    describe "post_color_2" do
      it "should return what is set in env" do
        test_env = ENV["POST_COLOR_2"]
        ENV["POST_COLOR_2"] = "#07c"
        expect(EnvironmentService.post_color_2).to eq("#07c")
        ENV["POST_COLOR_2"] = test_env
      end
    end

    describe "post_color_3" do
      it "should return what is set in env" do
        test_env = ENV["POST_COLOR_3"]
        ENV["POST_COLOR_3"] = "#07c"
        expect(EnvironmentService.post_color_3).to eq("#07c")
        ENV["POST_COLOR_3"] = test_env
      end
    end

    describe "post_color_4" do
      it "should return what is set in env" do
        test_env = ENV["POST_COLOR_4"]
        ENV["POST_COLOR_4"] = "#07c"
        expect(EnvironmentService.post_color_4).to eq("#07c")
        ENV["POST_COLOR_4"] = test_env
      end
    end
  end
end
