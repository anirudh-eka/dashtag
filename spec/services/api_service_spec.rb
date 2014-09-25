require 'spec_helper'

describe APIService do
  it 'returns Grams' do
    expect(GramFactory).to receive(:make_grams).with(SampleInstagramResponses.instagram_response)
    sleep ENV["API_Rate"].to_i + 0.5
    APIService.instance.get_posts("#{ENV["HASHTAG"]}")
  end

  it 'returns Tweets' do
    expect(TweetFactory).to receive(:make_tweets).with(SampleTweetResponses.tweet_response)
    sleep ENV["API_Rate"].to_i + 0.5
    APIService.instance.get_posts("#{ENV["HASHTAG"]}")
  end
end