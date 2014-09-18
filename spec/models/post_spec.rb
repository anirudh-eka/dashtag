require 'spec_helper'

describe Post do

  it 'should list all posts in descending order' do
    gram_one = Gram.create!(
      screen_name: "qwerty",
      created_at: "Fri Sep 21 23:40:54 +0000 2012",
      profile_image_url: "xyz",
      text: "Hey there",
      media_url: "abc")

    tweet_one = Tweet.create!(
      text: "Thee Namaste Nerdz. ##{ENV["HASHTAG"]}",
      screen_name: "bullcityrecords",
      created_at: "Fri Sep 21 22:40:54 +0000 2012",
      profile_image_url: "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg")


    gram_two = Gram.create!(
      screen_name: "ABCDEFG",
      created_at: "Fri Sep 20 23:40:54 +0000 2012",
      profile_image_url: "xyz",
      text: "friendship",
      media_url: "def")

    list_of_posts_in_desc_order = [gram_one, tweet_one, gram_two]
    
    expect(Post.all).to eq(list_of_posts_in_desc_order)
  end
end