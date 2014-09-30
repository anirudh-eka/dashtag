require 'spec_helper'

describe FeedController do
  describe 'GET #index' do
    let(:list_of_posts_in_desc_order) { (Post.all).sort_by{|post| post.time_of_post}.reverse }

    context "with HTML request" do 
      it 'should tell API service to get latest posts and update db' do
        expect(APIService.instance).to receive(:pull_posts).with(ENV["HASHTAG"])
        get :index, :format => :html
      end

      context "returns all posts in db" do 
        it "should call api service to pull most recent tweets and return posts in descending order", dont_run_in_snap: true do
          past, present, future = Time.now - 1, Time.now, Time.now + 1

          second_post = FactoryGirl.create(:post, created_at: present, text: "float like a butterfly", time_of_post: present)
          first_post = FactoryGirl.create(:post, created_at: past, text: "floated like a butterfly", time_of_post: past)
          third_post = FactoryGirl.create(:post, created_at: future, text: "will float like a butterfly", time_of_post: future)

          expect(APIService.instance).to receive(:pull_posts)
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
      it "should render hashtag links for new twitter posts" do
        future = Time.now + 1

        FactoryGirl.create(:post, created_at: future, text: "float like a butterfly #word", time_of_post: future, source: 'twitter')
        get :index, :format => :json

        expect(assigns(:posts).first.text).to eq('float like a butterfly <a href="http://twitter.com/hashtag/word" target="_blank">#word</a>')
      end
    end
  end
end
