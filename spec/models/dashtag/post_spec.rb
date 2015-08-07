require 'spec_helper'

module Dashtag
  describe Post do

    it { should validate_presence_of(:screen_name) }
    it { should validate_presence_of(:time_of_post) }
    it { should validate_presence_of(:profile_image_url) }
    it { should validate_presence_of(:source) }
    context "when disable retweets is turned off" do
      before(:each) do
        expect(SettingStore).to receive(:disable_retweets) {true}
      end

      it "should validate that the post is not a retweet" do
        retweet = FactoryGirl.build(:post,
          text: "RT @akacharleswade: Pouring rain. So what. Stay in these streets! #UmbrellaRevolution",
          source: "twitter")
        expect{ retweet.save! }.to raise_error()
        expect(retweet.errors.messages[:text]).to eq(["can't be a retweet"])
      end
    end

    context "when number of posts hit db_row_limit" do
      before(:each) do
        allow(SettingStore).to receive(:db_row_limit) {NumSetting.parse(2)}
      end

      it "should delete oldest post" do
        oldest_tweet = FactoryGirl.create(:post, time_of_post: "Fri Sep 18 23:40:54 +0000 1980")
        FactoryGirl.create(:post, time_of_post: "Fri Sep 18 23:40:54 +0000 1990")
        new_tweet = FactoryGirl.create(:post,
          text: "Pouring rain. So what. #soWhat",
          source: "twitter",
          time_of_post: "Fri Sep 21 23:40:54 +0000 2014")

        expect(Post.all_sorted_posts.include?(oldest_tweet)).to be_falsy
      end

      it "should not delete oldest post if new one fails validation" do
        FactoryGirl.create(:post, time_of_post: "Fri Sep 18 23:40:54 +0000 1990")
        oldest_tweet = FactoryGirl.create(:post, time_of_post: "Fri Sep 18 23:40:54 +0000 1980")
        new_tweet = FactoryGirl.build(:post,
          text: "Pouring rain. So what. #soWhat",
          source: "twitter",
          screen_name: nil,
          time_of_post: "Fri Sep 21 23:40:54 +0000 2014")

        new_tweet.save
        expect(Post.all_sorted_posts.include?(oldest_tweet)).to be_truthy
      end
    end

    it 'should not equal another post when the attributes are different' do
      gram_one = FactoryGirl.create(:post, source: "instagram")
      gram_two = FactoryGirl.create(:post, screen_name: "someone_different", source: "instagram")
      expect(gram_one).to_not eq(gram_two)
    end

    describe "#next_posts" do
      let!(:third_post) {FactoryGirl.create(:post, created_at: Time.now , text: "will float like a butterfly", time_of_post: "Sep 18 23:40:54 +0000 2002")}
      let!(:second_post) { FactoryGirl.create(:post, created_at: Time.now - 5, text: "float like a butterfly", time_of_post: "Sep 18 23:40:54 +0000 2001") }
      let!(:first_post) { FactoryGirl.create(:post, created_at: Time.now - 10, text: "floated like a butterfly", time_of_post: "Sep 18 23:40:54 +0000 2000")}

      it 'should get next posts' do
        first_post.id, second_post.id = first_post.id, second_post.id
        next_posts = Post.next_posts(third_post)
        expect(next_posts).to eq([second_post, first_post])
      end

      it "should screen next posts based on censored words" do
        second_post.update_attribute(:text, "float like a moth")
        SettingStore.new(censored_words: "moth").store

        first_post.id, second_post.id = first_post.id, second_post.id
        next_posts = Post.next_posts(third_post)
        expect(next_posts).to eq([first_post])
      end

      it "should screen next posts based on censored users" do
        first_post.update_attribute(:screen_name, "someoneBad")
        SettingStore.new(censored_users: "@someoneBad").store

        first_post.id, second_post.id = first_post.id, second_post.id
        next_posts = Post.next_posts(third_post)
        expect(next_posts).to eq([second_post])
      end
    end

    describe "#limited_sorted_posts" do
      it 'should screen posts based on censored words' do
        post = FactoryGirl.create(:post, text: "somethingBad")
        SettingStore.new(censored_words: "somethingBad").store
        expect(Post.limited_sorted_posts 10).to_not include(post)
      end

      it 'should screen posts based on censored users' do
        post = FactoryGirl.create(:post, screen_name: "someoneBad")
        SettingStore.new(censored_users: "@someoneBad").store
        expect(Post.limited_sorted_posts 10).to_not include(post)
      end
    end

    describe '#get_new_posts' do
      let(:last_update_time) { Time.now.to_f }
      let(:time_of_new_post) { last_update_time + 1 }
      let(:time_of_old_post) { last_update_time - 1 }

      it "should pull tell api service to pull posts" do
        last_update_time = Time.now.to_f
        expect(APIService.instance).to receive(:pull_posts)
        Post.get_new_posts(last_update_time)
      end

      it "should return only posts after time passed" do
        allow(APIService.instance).to receive(:pull_posts).and_return(true)

        old_post = FactoryGirl.create(:post,
                    created_at: Time.at(time_of_old_post),
                    time_of_post: Time.at(time_of_old_post),
                    text: "the old post")

        new_post = FactoryGirl.create(:post,
                    created_at: Time.at(time_of_new_post),
                    time_of_post: Time.at(time_of_new_post),
                    text: "the new post")


        result = Post.get_new_posts(last_update_time)
        expect(result.count).to eq(1)
        expect(result.first.id).to eq(new_post.id)
      end
    end
  end
end
