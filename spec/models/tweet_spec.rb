require 'spec_helper'

describe Tweet do
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:screen_name) }
  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:profile_image_url) }
  it { should validate_uniqueness_of(:text) }

  it 'should equal another tweet when the attributes are equal' do
    tweet_one = Tweet.create(text: "Thee Namaste Nerdz. #NAAwayDay",
        screen_name: "bullcityrecords",
        created_at: "Fri Sep 21 23:40:54 +0000 2012",
        profile_image_url: "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg")

    tweet_two = Tweet.create(text: "Thee Namaste Nerdz. #NAAwayDay",
        screen_name: "bullcityrecords",
        created_at: "Fri Sep 21 23:40:54 +0000 2012",
        profile_image_url: "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
        media_url: "http://pbs.twimg.com/media/BoqqU1wIMAAr_zO.jpg")
    
    expect(tweet_one).to_not eq(tweet_two)
  end

end
