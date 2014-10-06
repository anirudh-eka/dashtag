require 'spec_helper'

describe Post do
  it { should validate_presence_of(:screen_name) }
  it { should validate_presence_of(:time_of_post) }
  it { should validate_presence_of(:profile_image_url) }
  it { should validate_presence_of(:source) }

  before :each do
    @gram_one = Post.create!(
      source: "instagram",
      screen_name: "qwerty",
      time_of_post: "Fri Sep 21 23:40:54 +0000 2012",
      profile_image_url: "xyz",
      text: "Hey there",
      media_url: "abc",
      post_id: "123")

    @gram_two = Post.create!(
      source: "instagram",
      screen_name: "ABCDEFG",
      time_of_post: "Fri Sep 20 23:40:54 +0000 2012",
      profile_image_url: "xyz",
      text: "friendship",
      media_url: "def",
      post_id: "456")

    @tweet_one = Post.create!(
      source: "twitter",
      text: "Thee Namaste Nerdz. ##{ENV["HASHTAG"]}",
      screen_name: "bullcityrecords",
      time_of_post: "Fri Sep 21 22:40:54 +0000 2012",
      profile_image_url: "http://a0.twimg.com/profile_images/447958234/Lichtenstein_normal.jpg",
      post_id: "789")


  end

  context "when getting all posts with a hashtag" do
    it 'should pull new posts from api' do
      expect(APIService.instance).to receive(:pull_posts)
      Post.all("#{ENV["HASHTAG"]}")
    end
  end
  
  context "when getting all posts without a hashtag" do
    it 'should not pull new posts from api' do
      expect(APIService.instance).to_not receive(:get_posts)
      Post.all
    end
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
  
  describe 'gets new posts since last pull' do
    context "when api does pull new posts" do 
      before(:each) do 
        allow(APIService.instance).to receive(:get_posts).and_return(true)
      end
      it "should return only posts after last pull", dont_run_in_snap: true do
        last_pull_stub = Time.now
        time_of_post = Time.now - 5

        old_post = Post.create!(screen_name: "cassius_clay",
                    profile_image_url: "stuff.com",
                    created_at: (last_pull_stub - 30),
                    time_of_post: (time_of_post),
                    source: "twitter",
                    text: "the old post",
                    post_id: "qwe")

        new_post = Post.create!(screen_name: "cassius_clay",
                    profile_image_url: "stuff.com",
                    created_at: (last_pull_stub + 30),
                    time_of_post: (time_of_post + 2),
                    source: "twitter",
                    text: "the new post",
                    post_id: "iop")

        allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub)
        allow(APIService.instance).to receive(:pull_posts).and_return(true)
        result = Post.get_new_posts("#{ENV["HASHTAG"]}")
        expect(result).to_not eq([old_post, new_post])
        expect(result).to eq([new_post])
      end
    end
    context "when api does not pull new posts" do 
      before(:each) do 
        allow(APIService.instance).to receive(:pull_posts).and_return(nil)
      end
      it "should return nil" do
        expect(Post.get_new_posts("#{ENV["HASHTAG"]}")).to be_nil
      end
    end
  end
end
