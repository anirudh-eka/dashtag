require 'spec_helper'
require 'rake'

module Dashtag
  describe 'home' do

    let(:twitter_profile_image) {"http://upload.wikimedia.org/wikipedia/commons/b/bf/Pembroke_Welsh_Corgi_600.jpg"}
    let(:twitter_media_image) {"http://media-cache-ak0.pinimg.com/736x/cf/69/d9/cf69d915e40a62409133e533b64186f1.jpg"}
    let(:instagram_profile_image) {"http://images.ak.instagram.com/profiles/profile_33110152_75sq_1380185157.jpg"}
    let(:instagram_media_image) {"http://scontent-a.cdninstagram.com/hphotos-xfa1/t51.2885-15/10684067_323739034474097_279647979_n.jpg"}

    before do
      @routes = Engine.routes
    end

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

      all('.reply').each do |link|
        expect(link[:href]).to start_with("https://twitter.com/intent/tweet?in_reply_to=")
        expect(link[:href].last).to match("[0-9]")
      end

      all('.retweet').each do |link|
        expect(link[:href]).to start_with("https://twitter.com/intent/retweet?tweet_id=")
        expect(link[:href].last).to match("[0-9]")
      end

      all('.favorite').each do |link|
        expect(link[:href]).to start_with("https://twitter.com/intent/favorite?tweet_id=")
        expect(link[:href].last).to match("[0-9]")
      end
    end

    xit 'should auto update only when on top of page', js: true do
      visit '/'
      sleep 1
      page.execute_script('window.scrollTo(0,100000)')
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
      page.should have_content('TWITTER USER TWEETS')
      page.should have_content("@#{EnvironmentService.twitter_users.first}")

      # content from Instagram User API
      page.should have_content('POST FROM INSTAGRAM_USER')
      page.should have_content('@INSTAGRAM_USER')

      # only auto updates on top of page
      page.should_not have_content("DAT ISH CRAY AIN'T IT ##{EnvironmentService.hashtag_array.first}")

      click_link "up"
      sleep 5
      page.should have_content("DAT ISH CRAY AIN'T IT ##{EnvironmentService.hashtag_array.first}")
    end

  end
end

module Capybara
  class Session
    def has_image?(src)
      has_xpath?("//img[contains(@src,\"#{src}\")]")
    end
  end
end
