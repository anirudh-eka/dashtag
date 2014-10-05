require 'spec_helper'

describe VineVideoHelper do
  context 'with video' do
    let(:post_with_video) { FactoryGirl.create(:post, text: 'check out this vine video! #amazing https://vine.co/v/abcde', source: 'twitter') }

    describe 'vine_extract_id' do
      subject { helper.vine_extract_id post_with_video.text }
      it { should eq('abcde') }
    end

    describe 'vine_embed_twitter' do
      subject { helper.vine_embed_twitter post_with_video }
      its([:text]) { should include('<iframe')}
      its([:text]) { should include('check out this vine video!') }
      its([:text]) { should include('#amazing') }
      its([:text]) { should include('vine.co/v/abcde/embed/simple') }
      its([:text]) { should_not include('<a href="https://vine') }
    end
  end

  context 'with no video' do
    let(:post_without_video) { FactoryGirl.create(:post, text: 'no video here!', source: 'twitter') }

    describe 'vine_embed_twitter' do
      subject { helper.vine_embed_twitter post_without_video }
      its([:text]) { should eq('no video here!') }
    end
  end
end
