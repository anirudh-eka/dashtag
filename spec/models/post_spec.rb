require 'spec_helper'

describe Post do

  it { should validate_presence_of(:screen_name) }
  it { should validate_presence_of(:time_of_post) }
  it { should validate_presence_of(:profile_image_url) }
  it { should validate_presence_of(:source) }
  context "when disable retweets is turned off" do
    before(:each) do
      expect(EnvironmentService).to receive(:disable_retweets) {true}
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
      allow(EnvironmentService).to receive(:db_row_limit) {2}
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
    let!(:third_post) {FactoryGirl.create(:post, created_at: Time.now , text: "will float like a butterfly", time_of_post: Time.now + 1)}
    let!(:second_post) { FactoryGirl.create(:post, created_at: Time.now - 5, text: "float like a butterfly", time_of_post: Time.now) }
    let!(:first_post) { FactoryGirl.create(:post, created_at: Time.now - 10, text: "floated like a butterfly", time_of_post: Time.now - 1)}

    it 'should get next posts', dont_run_in_snap: true do
      first_post.id, second_post.id = first_post.id, second_post.id
      next_posts = Post.next_posts(third_post)
      expect(next_posts).to eq([second_post, first_post])
    end

    it "should screen next posts based on censored words", dont_run_in_snap: true do
      second_post.update_attribute(:text, "float like a moth")
      allow(EnvironmentService).to receive(:censored_words).and_return("moth")

      first_post.id, second_post.id = first_post.id, second_post.id
      next_posts = Post.next_posts(third_post)
      expect(next_posts).to eq([first_post])
    end

    it "should screen next posts based on censored users", dont_run_in_snap: true do
      first_post.update_attribute(:screen_name, "someoneBad")
      allow(EnvironmentService).to receive(:censored_users).and_return("someoneBad")

      first_post.id, second_post.id = first_post.id, second_post.id
      next_posts = Post.next_posts(third_post)
      expect(next_posts).to eq([second_post])
    end
  end

  describe "#limited_sorted_posts" do
    it 'should screen posts based on censored words' do
      post = FactoryGirl.create(:post, text: "somethingBad")
      allow(EnvironmentService).to receive(:censored_words).and_return("somethingBad")
      expect(Post.limited_sorted_posts 10).to_not include(post)
    end

    it 'should screen posts based on censored users' do
      post = FactoryGirl.create(:post, screen_name: "someoneBad")
      allow(EnvironmentService).to receive(:censored_users).and_return("someoneBad")
      expect(Post.limited_sorted_posts 10).to_not include(post)
    end
  end

  describe 'gets new posts since last pull' do
    context "when api does pull new posts" do
      before(:each) do
        allow(APIService.instance).to receive(:get_posts).and_return(true)
      end
      it "should return only posts after last pull", dont_run_in_snap: true do
        last_pull_stub = Time.now
        time_of_post = Time.now - 5

        old_post = Post.create!(screen_name: "cassius_clay",
                    profile_image_url: "stuff.com",
                    created_at: (last_pull_stub - 30),
                    time_of_post: (time_of_post),
                    source: "twitter",
                    text: "the old post",
                    post_id: "qwe")

        new_post = Post.create!(screen_name: "cassius_clay",
                    profile_image_url: "stuff.com",
                    created_at: (last_pull_stub + 30),
                    time_of_post: (time_of_post + 2),
                    source: "twitter",
                    text: "the new post",
                    post_id: "iop")

        allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
        allow(APIService.instance).to receive(:pull_posts).and_return(true)
        result = Post.get_new_posts
        expect(result).to_not eq([old_post, new_post])
        expect(result).to eq([new_post])
      end
    end
    context "when api does not pull new posts" do
      before(:each) do
        allow(APIService.instance).to receive(:pull_posts).and_return(nil)
      end
      it "should return empty" do
        expect(Post.get_new_posts).to be_empty
      end
    end
  end
end
