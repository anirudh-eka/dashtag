require 'spec_helper'

describe InstagramVideoHelper do
  context 'with video' do
    let(:post_with_video) { FactoryGirl.create(:post, media_url: nil, text: 'check out this instagram video!', source: 'instagram') }

    describe 'embed_instagram_video' do
      subject { helper.embed_instagram_video post_with_video }
      its([:text]) { should include('<iframe')}
      its([:text]) { should include('instagram.com/p/12345/embed') }
      its([:text]) { should_not include('<a href="https://instagram') }
    end
  end

  context 'with no video' do
    let(:post_without_video) { FactoryGirl.create(:post, text: 'no video here!', source: 'instagram', media_url: "some media url") }

    describe 'embed_instagram_video' do
      subject { helper.embed_instagram_video post_without_video }
      its([:text]) { should eq('no video here!') }
    end
  end
end
