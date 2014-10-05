require 'spec_helper'

describe PostHelper do
  let(:twitter_post) { FactoryGirl.create(:post, created_at: Time.now, text: '#helpus "@batman and @robin!" #gothamcity #gotham http://dccomics.com http://www.imdb.com/title/tt0118688/', time_of_post: Time.now, source: 'twitter') }

  let(:twitter_post_with_youtube) { FactoryGirl.create(:post, created_at: Time.now, text: 'Its #Friday, you aint got no job... https://www.youtube.com/watch?v=q4tbZ7xnEjk', time_of_post: Time.now, source: 'twitter') }

  let(:instagram_post) { FactoryGirl.create(:post, created_at: Time.now, text: '@Julia and @Julian you both should support #JackieRobinsonWest http://jackierobinsonwest.org/', time_of_post: Time.now, source: 'instagram') }

  let(:instagram_post_with_youtube) { FactoryGirl.create(:post, created_at: Time.now, text: 'Video is now live on YouTube enjoy: https://m.youtube.com/watch?v=Qi6wjbKMnRA #lunaFollow', time_of_post: Time.now, source: 'instagram') }

  describe 'add_post_links' do
    context 'Twitter post' do
      context 'should render links for regular URLs, hashtag and username' do
        subject { helper.add_post_links twitter_post }
        it { should include('//twitter.com/hashtag/helpus') }
        it { should include('//twitter.com/@batman') }
        it { should include('<a href="http://www.imdb.com/title/tt0118688/"') }
        it { should include('http://www.imdb.com/title/tt0118688/</a>') }
      end

      context 'should embed but not render link for youtube' do
        subject { helper.add_post_links twitter_post_with_youtube }
        it { should include('<iframe')}
        it { should_not include('<a href="https://m.youtube.com/watch?v=Qi6wjbKMnRA"')}
        it { should include('<a href="http://twitter.com/hashtag/Friday"')}
      end
    end

    context 'Instagram post' do
      context 'should render links for regular URLs, hashtag and username' do
        subject { helper.add_post_links instagram_post }
        it { should_not include('//twitter.com/hashtag/JackieRobinsonWest') }
        it { should include('//instagram.com/Julia') }
        it { should include('<a href="http://jackierobinsonwest.org/"') }
        it { should include('>http://jackierobinsonwest.org/</a>') }
      end

      context 'should embed but not render link for youtube' do
        subject { helper.add_post_links instagram_post_with_youtube }
        it { should_not include('<iframe')}
        it { should include('Video is now live on YouTube enjoy:')}
        it { should include('<a href="https://m.youtube.com/watch?v=Qi6wjbKMnRA"')}
        it { should_not include('#lunaFollow</a>')}
      end
    end

  end

  describe 'link_usernames' do
    context 'Twitter post' do
      subject { helper.link_usernames twitter_post }
      its([:text]) { should include('//twitter.com/@batman') }
      its([:text]) { should include('//twitter.com/@robin') }
    end

    context 'Instagram post' do
      subject { helper.link_usernames instagram_post }
      its([:text]) { should include('//instagram.com/Julia')}
      its([:text]) { should include('//instagram.com/Julian')}
    end
  end

  describe 'link_hashtags_twitter' do
    subject { helper.link_hashtags_twitter twitter_post }
    its([:text]) { should include('//twitter.com/hashtag/helpus') }
    its([:text]) { should include('//twitter.com/hashtag/gothamcity" target="_blank">#gothamcity</a>') }
    its([:text]) { should include('//twitter.com/hashtag/gotham" target="_blank">#gotham</a>') }
  end

  describe 'link_urls' do
    context 'should embed URLs for Twitter posts' do
      subject { helper.link_urls twitter_post }
      it { should include('<a href="http://dccomics.com"') }
      it { should include('http://dccomics.com</a>') }
      it { should include('<a href="http://www.imdb.com/title/tt0118688/"') }
      it { should include('http://www.imdb.com/title/tt0118688/</a>') }
    end

    context 'should embed URLs for Instagram posts' do
      subject { helper.link_urls instagram_post }
      it { should include('<a href="http://jackierobinsonwest.org/"') }
      it { should include('>http://jackierobinsonwest.org/</a>') }
    end

    context 'should not embed URL if truncated' do
      let(:truncated_twitter_post) { FactoryGirl.create(:post, source: 'twitter', text: 'H.E. Sheichk Prof Alh Yahya AJJ Jammeh Babili Mansa extends message http…') }
      subject { helper.link_urls truncated_twitter_post }
      it { should_not include('<a href="htt') }
    end
  end

  describe 'extract_usernames' do
    context 'should extract username for Twitter posts' do
      subject { helper.extract_usernames twitter_post.text }
      it { should eq(%w[@batman @robin]) }
    end
    context 'should extract username for Instagram posts' do
      subject { helper.extract_usernames instagram_post.text }
      it { should eq(%w[@Julia @Julian]) }
    end
  end

  describe 'extract_hashtags' do
    subject { helper.extract_hashtags twitter_post.text }
    it { should eq(%w[#helpus #gothamcity #gotham]) }
  end

  describe 'extract_urls' do
    subject { helper.extract_urls twitter_post.text }
    it { should eq(%w[http://dccomics.com http://www.imdb.com/title/tt0118688/]) }
  end
end
