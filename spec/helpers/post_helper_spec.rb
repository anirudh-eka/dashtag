require 'spec_helper'

describe PostHelper do
  let(:twitter_post) { FactoryGirl.create(:post, text: '#helpus "@batman and @robin!" #gothamcity #gotham http://dccomics.com http://www.imdb.com/title/tt0118688/', source: 'twitter') }

  let(:instagram_post) { FactoryGirl.create(:post, text: '@Julia and @Julian you both should support #JackieRobinsonWest http://jackierobinsonwest.org/', source: 'instagram') }

  describe 'add_post_links' do
    let(:twitter_post_with_videos) { FactoryGirl.create(:post, text: 'Its #Friday, you aint got no job... https://vine.co/v/MI3PU9Ag9Wu https://www.youtube.com/watch?v=q4tbZ7xnEjk', source: 'twitter') }

    let(:instagram_post_with_videos) { FactoryGirl.create(:post, text: 'Video is now live on YouTube enjoy: https://m.youtube.com/watch?v=Qi6wjbKMnRA #lunaFollow', source: 'instagram') }

    context 'Twitter post' do
      context 'should render links for regular URLs, hashtag and username' do
        subject { helper.add_post_links twitter_post }
        it { should include('//twitter.com/hashtag/helpus') }
        it { should include('//twitter.com/@batman') }
        it { should include('<a href="http://www.imdb.com/title/tt0118688/"') }
        it { should include('http://www.imdb.com/title/tt0118688/</a>') }
      end

      context 'should embed but not render link for videos' do
        subject { helper.add_post_links twitter_post_with_videos }
        it { should include('<iframe')}
        it { should_not include('<a href="https://www.youtube.com/watch?v=q4tbZ7xnEjk"')}
        it { should_not include('<a href="https://vine.co/v/MI3PU9Ag9Wu"')}
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
        subject { helper.add_post_links instagram_post_with_videos }
        it { should_not include('<iframe')}
        it { should include('Video is now live on YouTube enjoy:')}
        it { should include('<a href="https://m.youtube.com/watch?v=Qi6wjbKMnRA"')}
        it { should_not include('#lunaFollow</a>')}
      end
    end

  end

  describe 'link_mentions' do
    context 'Twitter post' do
      subject { helper.link_mentions twitter_post }
      its([:text]) { should include('//twitter.com/@batman') }
      its([:text]) { should include('//twitter.com/@robin') }
    end

    context 'Instagram post' do
      subject { helper.link_mentions instagram_post }
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

    context 'should not get username if truncated' do
      subject { helper.extract_usernames '@Dostoyevsky @Tolstoy @Nabokov @Pushk… @ronald...' }
      it { should eq(%w[@Dostoyevsky @Tolstoy @Nabokov]) }
    end
  end

  describe 'extract_hashtags' do
    context 'should get hashtags for Twitter post' do
      subject { helper.extract_hashtags twitter_post.text }
      it { should eq(%w[#helpus #gothamcity #gotham]) }
    end

    context 'should not get hashtag if truncated' do
      subject { helper.extract_hashtags '#letstrythis #willitwork #hashtagoveruse #though… #ronald...' }
      it { should eq(%w[#letstrythis #willitwork #hashtagoveruse]) }
    end
  end

  describe 'extract_urls' do
    context 'should get URLs for Twitter post' do
      subject { helper.extract_urls twitter_post.text }
      it { should eq(%w[http://dccomics.com http://www.imdb.com/title/tt0118688/]) }
    end

    context 'should not get URL if truncated' do
      subject { helper.extract_urls 'http://www.thoughtworks.com http… http...' }
      it { should eq(%w[http://www.thoughtworks.com]) }
    end
  end
end
