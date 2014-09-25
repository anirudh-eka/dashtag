require 'spec_helper'

describe TweetFactory do

  let(:response) { SampleTweetResponses.tweet_response }
  
  it 'should make tweets from twitter response' do

    test_tweets = [
      Post.new(
        source: "twitter",
        text: "Thee Namaste Nerdz. ##{ENV["HASHTAG"]}",
        screen_name: "bullcityrecords",
        time_of_post: "Fri Sep 21 23:40:54 +0000 2012",
        profile_image_url: "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
        media_url: "https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg"
      ),
      Post.new(
        source: "twitter",
        text: "Mexican Heaven, Mexican Hell ##{ENV["HASHTAG"]}",
        screen_name: "MonkiesFist",
        time_of_post: "Fri Sep 21 23:30:20 +0000 2012",
        profile_image_url: "http://a0.twimg.com/profile_images/2219333930/Froggystyle_normal.png"
      )
    ]
    

    factory_tweets = TweetFactory.make_tweets(response)

    expect(Post.tweets).to eq(test_tweets)
    expect(Post.tweets.reverse).to_not eq(test_tweets)
  end

  it 'should not add tweets with text that is already in the db' do
      test_tweets = [
      Post.new(
        source: "twitter",
        text: "Thee Namaste Nerdz. ##{ENV["HASHTAG"]}",
        screen_name: "bullcityrecords",
        time_of_post: "Fri Sep 21 23:40:54 +0000 2012",
        profile_image_url: "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
        media_url: "https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg"
      ),
      Post.new(
        source: "twitter",
        text: "Mexican Heaven, Mexican Hell ##{ENV["HASHTAG"]}",
        screen_name: "MonkiesFist",
        time_of_post: "Fri Sep 21 23:30:20 +0000 2012",
        profile_image_url: "http://a0.twimg.com/profile_images/2219333930/Froggystyle_normal.png"
      )
    ]

    TweetFactory.make_tweets(response)
    TweetFactory.make_tweets(response)
    expect(Post.tweets).to eq(test_tweets)
    expect(Post.tweets.reverse).to_not eq(test_tweets)
  end

  it "should not add tweets with censored words" do 
    response = SampleTweetResponses.tweets_with_censored_words

    TweetFactory.make_tweets(response)

    expect(Post.tweets).to be_empty
  end
end