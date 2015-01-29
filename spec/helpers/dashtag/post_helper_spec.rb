require 'spec_helper'

module Dashtag
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
          it { should include('//twitter.com/batman') }
          it { should include('href="http://www.imdb.com/title/tt0118688/"') }
          it { should include('http://www.imdb.com/title/tt0118688/') }
        end

        context 'should embed but not render link for videos' do
          subject { helper.add_post_links twitter_post_with_videos }
          it { should include('<iframe')}
          it { should_not include('href="https://www.youtube.com/watch?v=q4tbZ7xnEjk"')}
          it { should_not include('href="https://vine.co/v/MI3PU9Ag9Wu"')}
          it { should include('href="http://twitter.com/hashtag/Friday"')}
        end
      end

      context 'Instagram post' do
        context 'should render links for regular URLs, hashtag and username' do
          subject { helper.add_post_links instagram_post }
          it { should_not include('//twitter.com/hashtag/JackieRobinsonWest') }
          it { should include('//instagram.com/Julia') }
          it { should include('href="http://jackierobinsonwest.org/"') }
          it { should include('http://jackierobinsonwest.org/') }
        end

        context 'should embed but not render link for youtube' do
          subject { helper.add_post_links instagram_post_with_videos }
          it { should_not include('<iframe')}
          it { should include('Video is now live on YouTube enjoy:')}
          it { should include('href="https://m.youtube.com/watch?v=Qi6wjbKMnRA"')}
          it { should_not include('#lunaFollow</a>')}
        end
      end

    end

    describe 'link_mentions' do
      context 'Twitter post' do
        subject { (helper.link_mentions twitter_post).text }

        it { should include('//twitter.com/batman') }
        it { should include('//twitter.com/robin') }
      end

      context 'Instagram post' do
        subject { (helper.link_mentions instagram_post).text }
        it { should include('//instagram.com/Julia')}
        it { should include('//instagram.com/Julian')}
      end
    end

    describe 'link_hashtags_twitter' do
      subject { (helper.link_hashtags_twitter twitter_post).text }
      it { should include('//twitter.com/hashtag/helpus') }
      it { should include('//twitter.com/hashtag/gothamcity">#gothamcity</a>') }
      it { should include('//twitter.com/hashtag/gotham">#gotham</a>') }
    end

    describe 'link_urls' do
      context 'should embed URLs for Twitter posts' do
        subject { helper.link_urls twitter_post }
        it { should include('href="http://dccomics.com"') }
        it { should include('http://dccomics.com') }
        it { should include('href="http://www.imdb.com/title/tt0118688/"') }
        it { should include('http://www.imdb.com/title/tt0118688/') }
      end

      context 'should embed URLs for Instagram posts' do
        subject { helper.link_urls instagram_post }
        it { should include('href="http://jackierobinsonwest.org/"') }
        it { should include('>http://jackierobinsonwest.org/') }
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

    context "instagram" do

      context 'with video' do
        let(:post_with_video) { FactoryGirl.create(:post, media_url: nil, text: 'check out this instagram video!', source: 'instagram') }

        describe 'embed_instagram_video' do

          let(:post_with_embedded_video) {helper.embed_instagram_video post_with_video}

          it "should have iframe" do
            expect(post_with_embedded_video.text).to include('<iframe')
          end

          it "should have instagram embed url" do
            expect(post_with_embedded_video.text).to include('instagram.com/p/12345/embed')
          end

          it "should not have instagram" do
            expect(post_with_embedded_video.text).to_not include('<a href="https://instagram')
          end

        end
      end

      context 'with no video' do
        let(:post_without_video) { FactoryGirl.create(:post, text: 'no video here!', source: 'instagram', media_url: "some media url") }

        describe 'embed_instagram_video' do
          let(:post_without_embedded_video) {helper.embed_instagram_video post_without_video}

           it "should not have a video" do
            expect(post_without_embedded_video.text).to eq('no video here!')
          end
        end
      end
    end

    context "vine" do
      context 'with video' do
        let(:post_with_video) { FactoryGirl.create(:post, text: 'check out this vine video! #amazing https://vine.co/v/abcde', source: 'twitter') }

        describe 'vine_extract_id' do
          subject { helper.vine_extract_id post_with_video.text }
          it { should eq('abcde') }
        end

        describe 'vine_embed_twitter' do
          subject { (helper.vine_embed_twitter post_with_video).text }
          it { should include('<iframe')}
          it { should include('check out this vine video!') }
          it { should include('#amazing') }
          it { should include('vine.co/v/abcde/embed/simple') }
          it { should_not include('<a href="https://vine') }
        end
      end

      context 'with no video' do
        let(:post_without_video) { FactoryGirl.create(:post, text: 'no video here!', source: 'twitter') }

        describe 'vine_embed_twitter' do
          subject { (helper.vine_embed_twitter post_without_video).text }
          it { should eq('no video here!') }
        end
      end
    end

    context "youtube" do
      let(:twitter_post) { FactoryGirl.create(:post, text: '#helpus "@batman and @robin!" #gotham http://youtu.be/a1b2c3d4 http://dccomics.com', source: 'twitter') }

      let(:video_embed_code) do
        '<iframe width="560" height="315" src="//www.youtube.com/embed/1-sBRRWBxSg" frameborder="0" allowfullscreen></iframe>'
      end

      let(:video_embed_code_with_list) do
        '<iframe width="560" height="315" src="//www.youtube.com/embed/1-sBRRWBxSg?list=PL0CCC6BD6AFF097B1" frameborder="0" allowfullscreen></iframe>'
      end

      describe 'youtube_embed_twitter' do
        subject { (helper.youtube_embed_twitter twitter_post).text }
        it { should include('<iframe') }
        it { should include('youtube.com/embed/a1b2c3d4') }
        it { should_not include('href="http://youtu.be"') }
      end

      describe 'youtube_extract_id' do
        context 'video_embed_code' do
          subject { helper.youtube_extract_id video_embed_code }
          it { should eq('1-sBRRWBxSg')}
        end

        context 'video_embed_code with list' do
          subject { helper.youtube_extract_id video_embed_code_with_list }
          it { should eq('1-sBRRWBxSg')}
        end

        context 'twitter' do
          subject { helper.youtube_extract_id twitter_post.text}
          it { should eq('a1b2c3d4') }
        end
      end

      describe 'has_youtube?' do
        context 'no youtube' do
          subject { helper.has_youtube? "hello, world" }
          it { should be(false) }
        end

        context 'youtube embed code' do
          subject { helper.has_youtube? video_embed_code }
          it { should be(true) }
        end

        context 'youtube embed code with list' do
          subject { helper.has_youtube? video_embed_code_with_list }
          it { should be(true) }
        end
      end
    end
  end
end
