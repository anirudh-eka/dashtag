require 'spec_helper'

describe YoutubeVideoHelper do
  let(:tweet_text) do
    '#helpus "@batman and @robin!" #gotham http://youtu.be/a1b2c3d4 http://dccomics.com'
  end

  let(:facebook_post) do
  "<a href=\"https://www.facebook.com/l.php?u=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DcGFdIEZRH5k%26index%3D1%26list%3DPLQ9B-p5Q-YOOB3eYHFnysjca8RxgUQ9mH&amp;h=hAQHr1VCB&amp;s=1\" rel=\"nofollow nofollow\" target=\"_blank\" onmouseover=\"LinkshimAsyncLink.swap(this, &quot;https:\\/\\/www.youtube.com\\/watch?v=cGFdIEZRH5k&amp;index=1&amp;list=PLQ9B-p5Q-YOOB3eYHFnysjca8RxgUQ9mH&quot;);\" onclick=\"LinkshimAsyncLink.swap(this, &quot;https:\\/\\/www.facebook.com\\/l.php?u=https\\u00253A\\u00252F\\u00252Fwww.youtube.com\\u00252Fwatch\\u00253Fv\\u00253DcGFdIEZRH5k\\u002526index\\u00253D1\\u002526list\\u00253DPLQ9B-p5Q-YOOB3eYHFnysjca8RxgUQ9mH&amp;h=hAQHr1VCB&amp;s=1&quot;);\">https://www.youtube.com/watch?v=cGFdIEZRH5k&amp;index=1&amp;list=PLQ9B-p5Q-YOOB3eYHFnysjca8RxgUQ9mH</a><br/><br/><a href=\"https://www.facebook.com/l.php?u=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DcGFdIEZRH5k%26index%3D1%26list%3DPLQ9B-p5Q-YOOB3eYHFnysjca8RxgUQ9mH&amp;h=8AQHt_PQv&amp;s=1\" id=\"\" title=\"\" target=\"\" onclick=\"LinkshimAsyncLink.swap(this, &quot;https:\\/\\/www.facebook.com\\/l.php?u=https\\u00253A\\u00252F\\u00252Fwww.youtube.com\\u00252Fwatch\\u00253Fv\\u00253DcGFdIEZRH5k\\u002526index\\u00253D1\\u002526list\\u00253DPLQ9B-p5Q-YOOB3eYHFnysjca8RxgUQ9mH&amp;h=8AQHt_PQv&amp;s=1&quot;);\" style=\"\" rel=\"nofollow\" onmouseover=\"LinkshimAsyncLink.swap(this, &quot;https:\\/\\/www.youtube.com\\/watch?v=cGFdIEZRH5k&amp;index=1&amp;list=PLQ9B-p5Q-YOOB3eYHFnysjca8RxgUQ9mH&quot;);\"><img class=\"img\" src=\"https://fbexternal-a.akamaihd.net/safe_image.php?d=AQD8QY6FxrkMvhbq&amp;w=130&amp;h=130&amp;url=http%3A%2F%2Fi.ytimg.com%2Fvi%2FcGFdIEZRH5k%2Fmaxresdefault.jpg\" alt=\"\" style=\"height:90px;\" /></a><br/><a href=\"https://www.facebook.com/l.php?u=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DcGFdIEZRH5k%26index%3D1%26list%3DPLQ9B-p5Q-YOOB3eYHFnysjca8RxgUQ9mH&amp;h=NAQER85Nw&amp;s=1\" id=\"\" target=\"_blank\" onclick=\"LinkshimAsyncLink.swap(this, &quot;https:\\/\\/www.facebook.com\\/l.php?u=https\\u00253A\\u00252F\\u00252Fwww.youtube.com\\u00252Fwatch\\u00253Fv\\u00253DcGFdIEZRH5k\\u002526index\\u00253D1\\u002526list\\u00253DPLQ9B-p5Q-YOOB3eYHFnysjca8RxgUQ9mH&amp;h=NAQER85Nw&amp;s=1&quot;);return StreamShareVideo.clickTitle(&quot;688543601231761&quot;, &quot;feed&quot;, event);\" style=\"\" rel=\"nofollow\" onmouseover=\"LinkshimAsyncLink.swap(this, &quot;https:\\/\\/www.youtube.com\\/watch?v=cGFdIEZRH5k&amp;index=1&amp;list=PLQ9B-p5Q-YOOB3eYHFnysjca8RxgUQ9mH&quot;);\">Why are so many black men in prison? • BRAVE NEW FILMS: JUSTICE #1</a><br/><br/>More Black Men Are In Prison Today Than Were Enslaved In 1850 What are the odds that you will go to prison? 1 out of 17 white guys wind up behind bars at som..."
  end

  let(:video_embed_code) do
    '<iframe width="560" height="315" src="//www.youtube.com/embed/1-sBRRWBxSg" frameborder="0" allowfullscreen></iframe>'
  end

  let(:video_embed_code_with_list) do
    '<iframe width="560" height="315" src="//www.youtube.com/embed/1-sBRRWBxSg?list=PL0CCC6BD6AFF097B1" frameborder="0" allowfullscreen></iframe>'
  end

  describe 'youtube_embed_twitter' do
    subject { helper.youtube_embed_twitter tweet_text }
    it { should include('<iframe') }
    it { should include('youtube.com/embed/a1b2c3d4') }
    it { should_not include('href="http://youtu.be"') }
  end

  describe 'youtube_flash_url' do
    context 'secure' do
      subject { helper.youtube_flash_url '1234', :secure }
      it { should include('https')}
      it { should include('1234')}
    end

    context 'not secure' do
      subject { helper.youtube_flash_url '1234' }
      it { should include('1234')}
      it { should_not include('https') }
    end
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
      subject { helper.youtube_extract_id tweet_text }
      it { should eq('a1b2c3d4') }
    end
  
    context 'facebook' do
      subject { helper.youtube_extract_id facebook_post }
      it { should eq('cGFdIEZRH5k') }
    end
  end

  describe 'youtube_embed_facebook' do
    subject { helper.youtube_embed_facebook facebook_post }
    it { should include('<iframe') }
    it { should include('youtube.com/embed/cGFdIEZRH5k') }
    it { should_not include('<img') }
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

    context 'facebook with youtube' do
      subject { helper.has_youtube? facebook_post }
      it { should be(true) }
    end
  end
end
