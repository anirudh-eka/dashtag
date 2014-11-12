require 'spec_helper'

describe TweetParser do
  describe 'should parse the tweet' do
    let(:response) { SampleTweetResponses.tweet_response }

    it 'should parse tweet attributes from tweet response' do
      attributes = {  source: "twitter",
          text: "Thee Namaste Nerdz. ##{EnvironmentService.hashtag_array.first}",
          screen_name: "bullcityrecords",
          time_of_post: "Fri Sep 21 23:40:54 +0000 2012",
          profile_image_url: "http://upload.wikimedia.org/wikipedia/commons/b/bf/Pembroke_Welsh_Corgi_600.jpg",
          media_url: "http://media-cache-ak0.pinimg.com/736x/cf/69/d9/cf69d915e40a62409133e533b64186f1.jpg",
          post_id: "249292149810667520" }

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
  end

  describe 'strip photo urls' do
    it "should remove photo url in text" do
      response = SampleTweetResponses.tweet_response_with_image["statuses"].first
      result = TweetParser.strip_photo_url(response)
      expect(result).to_not include("http://t.co/8EO3BWutLc")
    end
  end

  describe 'replace links with short urls' do
    it "should " do
      response = SampleTweetResponses.tweet_response_with_youtube["statuses"].first
      result = TweetParser.replace_short_links(response)
      expect(result).to_not include("http://t.co/udp1Px9fLM")
      expect(result).to_not include("http://t.co/npprk1guZR")
      expect(result).to include("http://youtu.be/lmnop")
      expect(result).to include("http://youtube.com/abcde")
    end
  end
end
