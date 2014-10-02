require 'spec_helper'

describe PostHelper do
  let(:twitter_post) { FactoryGirl.create(:post, created_at: Time.now, text: '#helpus "@batman and @robin!" #gotham http://dccomics.com http://www.imdb.com/title/tt0118688/', time_of_post: Time.now, source: 'twitter') }
  let(:instagram_post) { FactoryGirl.create(:post, created_at: Time.now, text: '@Julia and @Julian you both should support #JackieRobinsonWest http://jackierobinsonwest.org/', time_of_post: Time.now, source: 'instagram') }

  describe 'add_tweet_links' do
    context 'Twitter posts' do
      subject { helper.add_post_links twitter_post }
      it { should include('//twitter.com/hashtag/helpus') }
      it { should include('//twitter.com/@batman') }
      it { should include('<a href="http://www.imdb.com/title/tt0118688/"') }
      it { should include('http://www.imdb.com/title/tt0118688/</a>') }
    end

    context 'Instagram posts' do
      subject { helper.add_post_links instagram_post }
      it { should_not include('//twitter.com/hashtag/JackieRobinsonWest') }
      it { should include('//instagram.com/Julia') }
      it { should include('<a href="http://jackierobinsonwest.org/"') }
      it { should include('>http://jackierobinsonwest.org/</a>') }
    end
  end

  describe 'link_usernames' do
    context 'Twitter posts' do
      subject { helper.link_usernames twitter_post }
      its([:text]) { should include('//twitter.com/@batman') }
      its([:text]) { should include('//twitter.com/@robin') }
    end
    context 'Instagram posts' do
      subject { helper.link_usernames instagram_post }
      its([:text]) { should include('//instagram.com/Julia')}
      its([:text]) { should include('//instagram.com/Julian')}
    end
  end

  describe 'link_hashtags_twitter' do
    context 'Twitter posts' do
      subject { helper.link_hashtags_twitter twitter_post }
      its([:text]) { should include('//twitter.com/hashtag/helpus') }
      its([:text]) { should include('//twitter.com/hashtag/gotham') }
    end
    context 'Instagram posts' do
      subject { helper.link_hashtags_twitter instagram_post }
      its([:text]) { should_not include('//twitter.com/hashtag/JackieRobinsonWest') }
    end
  end

  describe 'link_urls' do
    context 'Twitter posts' do
      subject { helper.link_urls twitter_post }
      its([:text]) { should include('<a href="http://dccomics.com"') }
      its([:text]) { should include('http://dccomics.com</a>') }
      its([:text]) { should include('<a href="http://www.imdb.com/title/tt0118688/"') }
      its([:text]) { should include('http://www.imdb.com/title/tt0118688/</a>') }
    end

    context 'Instagram posts' do
      subject { helper.link_urls instagram_post }
      its([:text]) { should include('<a href="http://jackierobinsonwest.org/"') }
      its([:text]) { should include('>http://jackierobinsonwest.org/</a>') }
    end

    context 'Too long text' do
      let(:truncated_twitter_post) { FactoryGirl.create(:post, source: 'twitter', text: 'H.E. Sheichk Prof Alh Yahya AJJ Jammeh Babili Mansa extends message http…') }
      subject { helper.link_urls truncated_twitter_post }
      its([:text]) { should_not include('<a href="htt') }
    end
  end

  describe 'extract_usernames' do
    context 'Twitter posts' do
      subject { helper.extract_usernames twitter_post.text }
      it { should eq(%w[@batman @robin]) }
    end
    context 'Instagram posts' do
      subject { helper.extract_usernames instagram_post.text }
      it { should eq(%w[@Julia @Julian]) }
    end
  end

  describe 'extract_hashtags' do
    subject { helper.extract_hashtags twitter_post.text }
    it { should eq(%w[#helpus #gotham]) }
  end

  describe 'extract_urls' do
    subject { helper.extract_urls twitter_post.text }
    it { should eq(%w[http://dccomics.com http://www.imdb.com/title/tt0118688/]) }
  end
end
