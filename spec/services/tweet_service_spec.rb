require 'spec_helper'

describe TweetService do
  it 'returns Tweets' do
    expect(TweetFactory).to receive(:make_tweets).with(SampleTweetResponses.tweet_response)
    sleep ENV["API_Rate"].to_i + 0.5
    TweetService.instance.get_tweets_by_hashtag("#{ENV["HASHTAG"]}")
  end
end