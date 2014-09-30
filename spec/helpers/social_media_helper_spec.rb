require 'spec_helper'

describe SocialMediaHelper do
  describe 'externalize_links' do
    subject { helper.externalize_links '<a href="#">foo</a>' }
    it { should match(/\<a .* target.*_blank/) }
  end

  describe 'video_link' do
    # context 'with vimeo link' do
    #   subject { helper.video_link? 'http://vimeo.com/12345' }
    #   it { should eq(true)}
    # end

    context 'with youtube link' do
      subject { helper.video_link? 'http://youtube.com/watch?v=12345' }
      it { should eq(true)}
    end

    context 'with youtu.be link' do
      subject { helper.video_link? 'http://youtu.be/12345' }
      it { should eq(true)}
    end
    
    context 'with non-video link' do
      subject { helper.video_link? 'http://thoughtworks.com' }
      it { should eq(false)}
    end
  end

end
