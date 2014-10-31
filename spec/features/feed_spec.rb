require 'spec_helper'
require 'rake'

describe 'home' do
  let(:twitter_profile_image) {"http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg"}
  let(:twitter_media_image) {"https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg"}
  let(:instagram_profile_image) {"http://images.ak.instagram.com/profiles/profile_33110152_75sq_1380185157.jpg"}
  let(:instagram_media_image) {"http://scontent-a.cdninstagram.com/hphotos-xfa1/t51.2885-15/10684067_323739034474097_279647979_n.jpg"}

  it "should display post in db" do
    post = FactoryGirl.create(:post)

    visit '/'
    page.should have_content(post.text)
    page.should have_content(post.screen_name)
  end

  it 'should auto update posts after 5 seconds', js: true do

    visit '/'

    sleep 6

    page.should have_content("Thee Namaste Nerdz. ##{ENV["HASHTAG"]}")
    page.should have_content('@bullcityrecords')
    page.should have_css("i.fa.fa-2x.fa-twitter")
    page.should have_image(twitter_profile_image)
    page.should have_image(twitter_media_image)

    page.should have_content("#elevator #kiss #love #budapest #basilica #tired")
    page.should have_content('@pollywoah')
    page.should have_css("i.fa.fa-2x.fa-instagram")
    page.should have_image(instagram_profile_image)
    page.should have_image(instagram_media_image)
  end

end

module Capybara
  class Session
    def has_image?(src)
      has_xpath?("//img[contains(@src,\"#{src}\")]")
    end
  end
end

