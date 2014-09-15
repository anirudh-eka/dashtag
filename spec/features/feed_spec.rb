require 'spec_helper'
require 'rake'

describe 'home' do
  let(:profile_image) {"http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg"}
  let(:media_image) {"https://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg"}
	it 'should display title' do
		visit '/'
		page.should have_content('#NAAwayDay')
	end

  it 'should display single tweets details' do
    visit '/'

    page.should have_content('Thee Namaste Nerdz. #NAAwayDay')
    page.should have_content('@bullcityrecords')
    page.should have_content('Fri Sep 21 7:40 PM')
    page.should have_image(profile_image)
    page.should have_image(media_image)
  end

  xit 'should add a tweet via automatic update', :js=> true do
    visit '/'

    page.should have_content('Thee Namaste Nerdz. #NAAwayDay')
    page.should have_content('@bullcityrecords')
    page.should have_content('Fri Sep 21 7:40 PM')

    # p Tweet.all
    update_tweets_in_db
    # puts "after update"*8
    # p Tweet.all
    sleep(30.seconds)

    # page.should have_content("DAT ISH CRAY AIN'T IT #NAAwayDay")
    # page.should have_content('@bullcity')
    # page.should have_content('Fri Sep 21 7:50 PM')
    page.should have_content('Thee Namaste Nerdz. #NAAwayDay')
    page.should have_content('@bullcityrecords')
    page.should have_content('Fri Sep 21 7:40 PM')
  end

  it 'should not have several swear words' do
    stub_request(:get, "https://api.twitter.com/1.1/search/tweets.json?q=%23#{ENV["HASHTAG"]}").
      with(headers: {"Authorization"=>/Bearer .+/}).
      to_return( {:status => 200, :body => @@cuss_response.to_json, :headers => {'content-type' => 'application/json'} })
    visit '/'

    ENV["CENSORED_WORDS"].split("|").each do |word|
      page.should_not have_content(word)
    end
  end

  def update_tweets_in_db
    Rails.application.load_tasks
    Rake::Task["update_feed"].invoke
  end
end

module Capybara
  class Session
    def has_image?(src)
      has_xpath?("//img[contains(@src,\"#{src}\")]")
    end
  end
end

