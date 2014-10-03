require 'spec_helper'

describe TweetParser do

  let(:response) { SampleTweetResponses.tweet_response }

  it 'should parse tweet attributes from tweet response' do 
    attributes = {  source: "twitter",
        text: "Thee Namaste Nerdz. ##{ENV["HASHTAG"]}",
        screen_name: "bullcityrecords",
        time_of_post: "Fri Sep 21 23:40:54 +0000 2012",
        profile_image_url: "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
        media_url: "https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg"}

    result = TweetParser.parse(response)

    expect(result).to include(attributes)
  end

  it "should not parse tweets with censored words" do 
    response = SampleTweetResponses.tweets_with_censored_words
    result = TweetParser.parse(response)
    expect(result).to be_empty
  end

   it "should not parse tweets from censored users" do 
    response = SampleTweetResponses.tweets_from_censored_users
    result = TweetParser.parse(response)
    expect(result).to be_empty
  end

  it "should replace url in text if same as image url" do 
    response = SampleTweetResponses.tweet_response_with_image
    result = TweetParser.parse(response)
    expect(result).to_not include("http://t.co/8EO3BWutLc")
  end
end
