require 'spec_helper'

describe InstagramVideoHelper do
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
