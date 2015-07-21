require 'spec_helper'
require 'web_mock_custom_helpers'

RSpec.configure do |c|
  c.include WebMockCustomHelpers
end

module Dashtag
  describe APIService do
    context 'when initialized' do
      it "sets last_update as a time" do
        expect(APIService.instance.last_update).to_not be_nil
        expect(APIService.instance.last_update.class).to eq(Time)
      end

      it "sets instagram_user_ids from Instagram Users" do
        instagram_ids = []
        instagram_id = SampleInstagramResponses.instagram_response["data"].first["id"]
        SettingStore.instagram_users.count.times { instagram_ids << instagram_id}

        SettingStore.instagram_user_ids.each { |id| instagram_ids << id }
        expect(APIService.instance.instagram_user_ids).to eq(instagram_ids)
      end
    end

    context 'when time since last pull is greater than api rate limit' do
      before(:each) do
        SettingStore.create_or_update_setting("instagram_client_id", TextSetting.parse("ig_client_id"))
        SettingStore.create_or_update_setting("twitter_consumer_key", TextSetting.parse("twitter_consumer_key"))
        SettingStore.create_or_update_setting("twitter_consumer_secret", TextSetting.parse("twitter_consumer_secret"))
        SettingStore.create_or_update_setting("hashtags", Hashtags.parse("#good, #life"))
        SettingStore.create_or_update_setting("twitter_users", SocialUsers.parse("@hello_twitter"))
        SettingStore.create_or_update_setting("instagram_users", SocialUsers.parse("@hello_instagram"))
        SettingStore.create_or_update_setting("api_rate", NumSetting.parse(15))
        stub_all_external_api_requests_with_current_settings
        last_pull_stub = Time.now - 20
        allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
      end

      it "parses grams and tweets from response and creates posts with parsed data (integration of pull)" do
        APIService.instance.pull_posts!
        #should have stored posts webmock from stubbed respons
        expect(Post.where(source: "twitter").count).to_not be(0)
        expect(Post.where(source: "instagram").count).to_not be(0)
      end

      it 'should pull instagram and twitter posts for each hashtag' do
        SettingStore.hashtags.each do |hashtags|
          expect(APIService.instance).to receive(:pull_instagram_posts_and_parse).with(hashtags).and_return([])
          expect(APIService.instance).to receive(:pull_twitter_posts_and_parse).with(hashtags).and_return([])
        end
        APIService.instance.pull_posts!
      end

      it 'should pull twitter posts from each user from twitter_users' do
        SettingStore.twitter_users.each do |user|
          expect(APIService.instance).to receive(:pull_twitter_posts_from_users_and_parse).with(user).and_return([])
        end
        APIService.instance.pull_posts!
      end

      it 'should pull instagram posts from each user_id from instagram_user_ids' do
        allow(APIService.instance).to receive(:instagram_user_ids).and_return([1234, 4345])
        APIService.instance.instagram_user_ids.each do |user_id|
          expect(APIService.instance).to receive(:pull_instagram_posts_from_users_and_parse).with(user_id).and_return([])
        end
        APIService.instance.pull_posts!
      end
    end

    describe 'loud pull' do
      before(:each) do
        SettingStore.create_or_update_setting("api_rate", NumSetting.parse(15))
        SettingStore.create_or_update_setting("hashtags", Hashtags.parse("#good, #life"))
        SettingStore.create_or_update_setting("twitter_users", SocialUsers.parse("@hello_twitter"))
        SettingStore.create_or_update_setting("instagram_users", SocialUsers.parse("@hello_instagram"))
        stub_all_external_api_requests_with_current_settings
      end
      context 'when time since last pull is less than api rate limit' do
        before(:each) do
          last_pull_stub = Time.now
          allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
        end
        it "should throw exception" do
          expect { APIService.instance.pull_posts! }.to raise_error("Time since last pull is less than api rate limit")
          SettingStore.create_or_update_setting("api_rate", NumSetting.parse(1))
        end
      end
      context "when time since last pull is greater than the api rate limit" do
        before(:each) do
          sleep SettingStore.api_rate.as_int + 0.5
        end
        context "when twitter api keys are not provided in the env" do
          it "should not pull from twitter and parse" do
            SettingStore.create_or_update_setting("twitter_consumer_key", nil)
            expect(APIService.instance).to_not receive(:pull_twitter_posts_and_parse)
            expect(APIService.instance).to_not receive(:pull_twitter_posts_from_users_and_parse)
            APIService.instance.pull_posts!
          end
        end
        context "when instagram api keys are not provided in the env" do
          it "should not pull from twitter and parse" do
            SettingStore.create_or_update_setting("instagram_client_id", nil)
            expect(APIService.instance).to_not receive(:pull_instagram_posts_and_parse)
            APIService.instance.pull_posts!
          end
        end
      end
    end

    describe "quiet pull" do
      it 'calls loud pull' do
        expect(APIService.instance).to receive(:pull_posts!).and_return(nil)
        APIService.instance.pull_posts
      end

      context 'when time since last pull is less than api rate limit' do
        before(:each) do
          SettingStore.create_or_update_setting("api_rate", NumSetting.parse(15))
          last_pull_stub = Time.now
          allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
        end
        it "should return nil" do
          expect(APIService.instance.pull_posts).to be_nil
        end
      end
    end
  end
end
