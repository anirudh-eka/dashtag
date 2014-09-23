require 'spec_helper'

describe Post do
  it { should validate_presence_of(:screen_name) }
  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:profile_image_url) }
  it { should validate_presence_of(:source) }


  before :each do
    @gram_one = Post.create!(
      source: "instagram",
      screen_name: "qwerty",
      created_at: "Fri Sep 21 23:40:54 +0000 2012",
      profile_image_url: "xyz",
      text: "Hey there",
      media_url: "abc")

    @tweet_one = Post.create!(
      source: "twitter",
      text: "Thee Namaste Nerdz. ##{ENV["HASHTAG"]}",
      screen_name: "bullcityrecords",
      created_at: "Fri Sep 21 22:40:54 +0000 2012",
      profile_image_url: "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg")


    @gram_two = Post.create!(
      source: "instagram",
      screen_name: "ABCDEFG",
      created_at: "Fri Sep 20 23:40:54 +0000 2012",
      profile_image_url: "xyz",
      text: "friendship",
      media_url: "def")
  end


  it 'should list all posts in descending order' do


    list_of_posts_in_desc_order = [@gram_one, @tweet_one, @gram_two]
    
    expect(Post.all).to eq(list_of_posts_in_desc_order)
  end


  it 'should not equal another post when the attributes are different' do
    expect(@gram_one).to_not eq(@gram_two)
  end

  it 'should return all tweets when doing Post.tweets' do
    expect(Post.tweets).to include(@tweet_one)
    expect(Post.tweets.count).to eq(1)
  end

    it 'should return all grams when doing Post.grams' do
    expect(Post.grams).to include(@gram_one)
    expect(Post.grams).to include(@gram_two)
    expect(Post.grams.count).to eq(2)
  end

end