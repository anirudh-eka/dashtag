require 'spec_helper'
require 'rake'

describe 'home' do

  let(:twitter_profile_image) {"http://upload.wikimedia.org/wikipedia/commons/b/bf/Pembroke_Welsh_Corgi_600.jpg"}
  let(:twitter_media_image) {"http://media-cache-ak0.pinimg.com/736x/cf/69/d9/cf69d915e40a62409133e533b64186f1.jpg"}
  let(:instagram_profile_image) {"http://images.ak.instagram.com/profiles/profile_33110152_75sq_1380185157.jpg"}
  let(:instagram_media_image) {"http://scontent-a.cdninstagram.com/hphotos-xfa1/t51.2885-15/10684067_323739034474097_279647979_n.jpg"}

  it "should display post in db" do
    post = FactoryGirl.create(:post)
    visit '/'

    page.should have_content(post.text)
    page.should have_content(post.screen_name)
  end

  it 'should display clickable web intents for all twitter posts', js: true do
    visit '/'
    count = Post.where(source: "twitter").count

    expect(page).to have_css("a.reply", count: count)
    expect(page).to have_css("a.retweet", count: count)
    expect(page).to have_css("a.favorite", count: count)

    expect(all('.reply')[0][:href]).to include("https://twitter.com/intent/tweet?in_reply_to=")
    expect(all('.retweet')[0][:href]).to include("https://twitter.com/intent/retweet?tweet_id=")
    expect(all('.favorite')[0][:href]).to include("https://twitter.com/intent/favorite?tweet_id=")
  end

  it 'should auto update only when on top of page', js: true do
    visit '/'

    # content from Twitter Search API
    page.should have_content("Thee Namaste Nerdz. ##{EnvironmentService.hashtag_array.first}")
    page.should have_content('@bullcityrecords')
    page.should have_image(twitter_profile_image)
    page.should have_image(twitter_media_image)

    # content from Instagram API
    page.should have_content("#elevator #kiss #love #budapest #basilica #tired")
    page.should have_content('@pollywoah')
    page.should have_image(instagram_profile_image)
    page.should have_image(instagram_media_image)

    # content from Twitter User Timeline API
    page.should have_content('USER TWEETS')
    page.should have_content("@#{EnvironmentService.twitter_users_array.first}")

    # only auto updates on top of page
    page.execute_script('window.scrollTo(0,100000)')
    sleep 5
    page.should_not have_content("DAT ISH CRAY AIN'T IT ##{EnvironmentService.hashtag_array.first}")

    click_link "up"
    page.should have_content("DAT ISH CRAY AIN'T IT ##{EnvironmentService.hashtag_array.first}")
  end

end

module Capybara
  class Session
    def has_image?(src)
      has_xpath?("//img[contains(@src,\"#{src}\")]")
    end
  end
end

