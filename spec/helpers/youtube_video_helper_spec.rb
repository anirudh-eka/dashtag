require 'spec_helper'

describe YoutubeVideoHelper do
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
