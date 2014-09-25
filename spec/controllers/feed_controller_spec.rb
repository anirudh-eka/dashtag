require 'spec_helper'

describe FeedController do
  describe 'GET #index' do
    let(:list_of_posts_in_desc_order) { (Post.all).sort_by{|post| post.created_at}.reverse }

    context "with HTML request" do 
      it 'should tell API service to get latest posts and update db' do
        expect(APIService.instance).to receive(:get_posts).with(ENV["HASHTAG"])
        get :index, :format => :html
      end

      it "should return all posts in db" do 
        get :index, :format => :html
        expect(assigns(:posts)).to eq(list_of_posts_in_desc_order)
      end
    end
    context "with JSON request" do 
      it "should tell service to get posts for social media feeds and update db" do
        expect(APIService.instance).to receive(:get_posts)
        get :index, :format => :json
      end

      it "should return new posts from the db", dont_run_in_snap: true do
        last_pull_stub = Time.now
        time_of_post = Time.now - 5

        old_post = Post.create!(screen_name: "cassius_clay",
                    profile_image_url: "stuff.com",
                    created_at: (last_pull_stub - 30),
                    time_of_post: (time_of_post),
                    source: "twitter",
                    text: "the old post")

        new_post = Post.create!(screen_name: "cassius_clay",
                    profile_image_url: "stuff.com",
                    created_at: (last_pull_stub + 30),
                    time_of_post: (time_of_post + 2),
                    source: "twitter",
                    text: "the new post")

        allow(APIService.instance).to receive(:last_update).and_return(last_pull_stub, last_pull_stub + 25)
        allow(APIService.instance).to receive(:get_posts).with(ENV["HASHTAG"]) {nil}

        get :index, :format => :json
        expect(assigns(:posts)).to_not eq([old_post, new_post])
        expect(assigns(:posts)).to eq([new_post])
      end
    end
  end
end