require 'spec_helper'

describe PostHelper do
  let(:twitter_post) { FactoryGirl.create(:post, created_at: Time.now,
                                          text: '#helpus "@batman and @robin!" #gotham', time_of_post: Time.now, source: 'twitter') }
  let(:instagram_post) { FactoryGirl.create(:post, created_at: Time.now, text: '@Julia and @Julian you both should support #JackieRobinsonWest',
                                            time_of_post: Time.now, source: 'instagram') }

  describe 'add_tweet_links' do
    context 'Twitter posts' do
      subject { helper.add_post_links twitter_post }
      it { should include('//twitter.com/hashtag/helpus') }
      it { should include('//twitter.com/@batman') }
    end

    context 'Instagram posts' do
      subject { helper.add_post_links instagram_post }
      it { should_not include('//twitter.com/hashtag/JackieRobinsonWest') }
      it { should include('//instagram.com/Julia') }
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

  describe 'link_hashtags' do
    context 'Twitter posts' do
      subject { helper.link_hashtags twitter_post }
      it { should include('//twitter.com/hashtag/helpus') }
      it { should include('//twitter.com/hashtag/gotham') }
    end
    context 'Instagram posts' do
      subject { helper.link_hashtags instagram_post }
      it { should_not include('//twitter.com/hashtag/JackieRobinsonWest') }
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
end
