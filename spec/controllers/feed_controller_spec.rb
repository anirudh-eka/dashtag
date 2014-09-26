require 'spec_helper'

describe FeedController do
  describe 'GET #index' do
    let(:list_of_posts_in_desc_order) { (Post.all).sort_by{|post| post.time_of_post}.reverse }

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
        expect(Post).to receive(:get_new_posts)
        get :index, :format => :json
      end
    end
  end
end