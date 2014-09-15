require 'spec_helper'

describe TweetService do
  it 'returns Tweets' do
    expected_tweets = double("tweets")
    expect(TweetFactory).to receive(:make_tweets).with(SampleTweetResponses.tweet_response)
    TweetService.get_tweets_by_hashtag("#{ENV["HASHTAG"]}")
  end
end