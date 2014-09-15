require 'spec_helper'

describe TweetFactory do
  
  it 'should make tweets from twitter response' do

    test_tweets = [
      Tweet.new(
        text: "Thee Namaste Nerdz. #NAAwayDay",
        screen_name: "bullcityrecords",
        created_at: "Fri Sep 21 23:40:54 +0000 2012",
        profile_image_url: "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
        media_url: "https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg"
      ),
      Tweet.new(
        text: "Mexican Heaven, Mexican Hell #NAAwayDay",
        screen_name: "MonkiesFist",
        created_at: "Fri Sep 21 23:30:20 +0000 2012",
        profile_image_url: "http://a0.twimg.com/profile_images/2219333930/Froggystyle_normal.png"
      )
    ]
    response = @@tweet_response

    factory_tweets = TweetFactory.make_tweets(response)

    expect(Tweet.all).to eq(test_tweets)
    expect(Tweet.all.reverse).to_not eq(test_tweets)
  end

  it 'should not add tweets with text that is already in the db' do
      test_tweets = [
      Tweet.new(
        text: "Thee Namaste Nerdz. #NAAwayDay",
        screen_name: "bullcityrecords",
        created_at: "Fri Sep 21 23:40:54 +0000 2012",
        profile_image_url: "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
        media_url: "https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg"
      ),
      Tweet.new(
        text: "Mexican Heaven, Mexican Hell #NAAwayDay",
        screen_name: "MonkiesFist",
        created_at: "Fri Sep 21 23:30:20 +0000 2012",
        profile_image_url: "http://a0.twimg.com/profile_images/2219333930/Froggystyle_normal.png"
      )
    ]
    response = @@tweet_response

    TweetFactory.make_tweets(response)
    TweetFactory.make_tweets(response)

    expect(Tweet.all).to eq(test_tweets)
    expect(Tweet.all.reverse).to_not eq(test_tweets)
  end

  it "should not add tweets with cuss words" do 
    response = @@cuss_response

    TweetFactory.make_tweets(response)

    expect(Tweet.all).to be_empty
  end
end