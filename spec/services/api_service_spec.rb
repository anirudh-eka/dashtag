require 'spec_helper'

describe APIService do
  context 'when time since last pull is greater than api rate limit' do
    before(:each) do
      ENV["API_RATE"] = 15.to_s
      last_pull_stub = Time.now - 20
      allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
    end

    it "parses grams and tweets from response and creates posts with parsed data" do
        tweet = FactoryGirl.build(:post,
          source: "twitter",
          text: "Thee Namaste Nerdz. ##{EnvironmentService.hashtag_array.first}",
          screen_name: "bullcityrecords",
          time_of_post: "Fri Sep 21 23:40:54 +0000 2012",
          profile_image_url: "http://upload.wikimedia.org/wikipedia/commons/b/bf/Pembroke_Welsh_Corgi_600.jpg",
          media_url: "http://media-cache-ak0.pinimg.com/736x/cf/69/d9/cf69d915e40a62409133e533b64186f1.jpg",
          post_id: "249292149810667520"
        )

        gram = FactoryGirl.build(:post, source: "instagram",
        text: "[ t o d a y ] \n#me #noi #iger #Italia #italian #love #myboyfriend #tatoo #tatoowhitlove #ops #opslove #sempreassieme #tiamo #aspasso #september #tempodelcavolo #chedobbiamofà",
        screen_name: "jolanda_cirigliano",
        time_of_post: DateTime.strptime("1410884290", "%s"),
        profile_image_url: "http://photos-h.ak.instagram.com/hphotos-ak-xfa1/10448944_676691075735007_832582745_a.jpg",
        media_url: "http://scontent-b.cdninstagram.com/hphotos-xaf1/t51.2885-15/10691617_1510929602485903_1047906060_n.jpg",
        post_id: "tA0dgLCmn5")
        APIService.instance.pull_posts!
        expect(Post.all).to include(tweet)
        expect(Post.all).to include(gram)
    end

    it 'should pull instagram and twitter posts for each hashtag' do
      EnvironmentService.hashtag_array.each do |hashtag|
        expect(APIService.instance).to receive(:pull_instagram_posts_and_parse).with(hashtag).and_return([])
        expect(APIService.instance).to receive(:pull_twitter_posts_and_parse).with(hashtag).and_return([])
      end
      APIService.instance.pull_posts!
    end

    it 'should pull twitter posts from each user from users_array' do
      EnvironmentService.users_array do |user|
        expect(APIService.instance).to receive(:pull_twitter_posts_from_users_and_parse).with(user).and_return([])
      end
      APIService.instance.pull_posts!
    end
  end

  describe 'loud pull' do
    context 'when time since last pull is less than api rate limit' do
      before(:each) do
        ENV["API_RATE"] = 15.to_s
        last_pull_stub = Time.now
        allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
      end
      it "should throw exception" do
        expect { APIService.instance.pull_posts! }.to raise_error("Time since last pull is less than api rate limit")
        ENV["API_RATE"] = 1.to_s
      end
    end
    context "when time since last pull is greater than the api rate limit" do
      before(:each) do
        sleep ENV["API_RATE"].to_i + 0.5
      end
      context "when twitter api keys are not provided in the env" do
        it "should not pull from twitter and parse" do
          default_env_twitter_keys = ENV["TWITTER_BEARER_CREDENTIALS"]
          ENV["TWITTER_BEARER_CREDENTIALS"] = ""
          expect(APIService.instance).to_not receive(:pull_twitter_posts_and_parse)
          expect(APIService.instance).to_not receive(:pull_twitter_posts_from_users_and_parse)
          APIService.instance.pull_posts!
          ENV["TWITTER_BEARER_CREDENTIALS"] = default_env_twitter_keys
        end
      end
      context "when instagram api keys are not provided in the env" do
        it "should not pull from twitter and parse" do
          default_env_instagram_keys = ENV["INSTAGRAM_CLIENT_ID"]
          ENV["INSTAGRAM_CLIENT_ID"] = ""
          expect(APIService.instance).to_not receive(:pull_instagram_posts_and_parse)
          APIService.instance.pull_posts!
          ENV["INSTAGRAM_CLIENT_ID"] = default_env_instagram_keys
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
        ENV["API_RATE"] = 15.to_s
        last_pull_stub = Time.now
        allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
      end
      it "should return nil" do
        expect(APIService.instance.pull_posts).to be_nil
      end
    end
  end
end
