require 'spec_helper'

describe TwitterHelper do
  let(:tweet_text) do
    '#helpus "@batman and @robin!" #gotham http://youtu.be/a1b2c3d4 http://dccomics.com'
  end

  describe 'add_tweet_links' do
    subject { helper.add_tweet_links tweet_text }
    it { should include('//twitter.com/hashtag/helpus') }
    it { should include('//twitter.com/@batman') }
    xit { should include('href="http://dccomics.com"') }
    it { should_not include('href="http://youtu.be"') }
    it { should include('<iframe') }
    it { should include('youtube.com/embed/a1b2c3d4') }
  end

  describe 'link_usernames' do
    subject { helper.link_usernames tweet_text }
    it { should include('//twitter.com/@batman') }
    it { should include('//twitter.com/@robin') }
  end

  describe 'link_hashtags' do
    subject { helper.link_hashtags tweet_text }
    it { should include('//twitter.com/hashtag/helpus') }
    it { should include('//twitter.com/hashtag/gotham') }
  end

  describe 'extract_usernames' do
    subject { helper.extract_usernames tweet_text }
    it { should eq(%w[@batman @robin]) }
  end

  describe 'extract_hashtags' do
    subject { helper.extract_hashtags tweet_text }
    it { should eq(%w[#helpus #gotham]) }
  end

  describe "restore_twitter_links" do
    let(:tweet_text) do
      'hello world! http://t.co/link http://t.co/youtube-link'
    end

    let(:tweet_urls) do
      [double(
	url: 'http://t.co/link',
	expanded_url: 'http://original-link',
	display_url: 'original-link'
      ), double(
	url: 'http://t.co/youtube-link',
	expanded_url: 'http://youtu.be/youtube-id',
	display_url: 'youtu.be/youtube-id'
      )]
    end

    subject { helper.restore_twitter_links tweet_text, tweet_urls }

    it { should_not include('http://t.co/link') }
    it { should include('href="http://original-link"') }
    it { should include('>original-link</a>') }

    it { should include('youtu.be/youtube-id') }
    it { should_not include('href="http://youtu.be/youtube-id"') }
    it { should_not include('http://t.co/youtube-link') }

  end
  
end
