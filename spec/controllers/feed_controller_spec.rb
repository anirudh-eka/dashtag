require 'spec_helper'

describe FeedController do
  describe 'GET #index' do
    let(:list_of_posts_in_desc_order) { (Post.all).sort_by{|post| post.time_of_post}.reverse }

    context "with HTML request" do 
      it 'should tell API service to get latest posts and update db' do
        expect(APIService.instance).to receive(:get_posts).with(ENV["HASHTAG"])
        get :index, :format => :html
      end

      context "returns all posts in db" do 
        it "should call api service to pull most recent tweets and return posts in descending order" do
          past, present, future = Time.now - 1, Time.now, Time.now + 1

          second_post = Post.create!(screen_name: "cassius_clay", created_at: present, text: "float like a butterfly", time_of_post: present, source: "twitter", profile_image_url: "stuff.com")
          first_post = Post.create!(screen_name: "cassius_clay", created_at: past, text: "float like a butterfly", time_of_post: past, source: "twitter", profile_image_url: "stuff.com")
          third_post = Post.create!(screen_name: "cassius_clay", created_at: future, text: "float like a butterfly", time_of_post: future, source: "twitter", profile_image_url: "stuff.com")

          expect(APIService.instance).to receive(:get_posts)
          get :index, :format => :html
          expect(assigns(:posts)).to eq([third_post, second_post, first_post])
        end
      end
    end
    context "with JSON request" do 
      it "should tell service to get posts for social media feeds and update db" do
        expect(Post).to receive(:get_new_posts)
        get :index, :format => :json
      end
    end
  end
end
