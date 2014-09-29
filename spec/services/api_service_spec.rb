require 'spec_helper'

describe APIService do
  context 'when time since last pull is greater than api rate limit' do
    before(:each) do
      ENV["API_Rate"] = 15.to_s
      last_pull_stub = Time.now - 20
      allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
    end
    it 'calls gram and tweet factories to make grams and tweets' do 
      expect(TweetFactory).to receive(:make_tweets).with(SampleTweetResponses.tweet_response)
      expect(GramParser).to receive(:make_grams).with(SampleInstagramResponses.instagram_response)

      APIService.instance.pull_posts!("#{ENV["HASHTAG"]}")
    end
  end

  context 'when time since last pull is less than api rate limit' do
    before(:each) do
      ENV["API_Rate"] = 15.to_s
      last_pull_stub = Time.now
      allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
    end
    it "should throw exception" do
      expect { APIService.instance.pull_posts!("#{ENV["HASHTAG"]}") }.to raise_error("Time since last pull is less than api rate limit")
    end
  end

  describe "quiet pull" do
    it 'calls loud pull' do 
      expect(APIService.instance).to receive(:pull_posts!).with("#{ENV["HASHTAG"]}").and_return(nil)
      APIService.instance.pull_posts("#{ENV["HASHTAG"]}")
    end

    context 'when time since last pull is less than api rate limit' do
      before(:each) do
        ENV["API_Rate"] = 15.to_s
        last_pull_stub = Time.now
        allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
      end
      it "should return nil" do
        expect(APIService.instance.pull_posts("#{ENV["HASHTAG"]}")).to be_nil
      end
    end
  end
end