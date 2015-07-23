require 'spec_helper'

module Dashtag
  describe FeedController do
    let(:second_post) { FactoryGirl.create(:post, created_at: Time.now, text: "float like a butterfly", time_of_post: Time.now) }
    let(:first_post) { FactoryGirl.create(:post, created_at: Time.now - 1, text: "floated like a butterfly", time_of_post: Time.now - 1) }
    let(:third_post) { FactoryGirl.create(:post, created_at: Time.now + 1, text: "will float like a butterfly", time_of_post: Time.now + 1) }
    before(:each) {allow(User).to receive(:owner_exists?) {true}}
    routes { Dashtag::Engine.routes }

    describe 'GET #index' do

      context "with HTML request" do
        context "returns all posts in db" do
          it "should return all posts in descending order" do
            array = [third_post, second_post, first_post]
            get :index, :format => :html
            expect(assigns(:posts)).to eql(array)
          end

          it "should limit number of posts to 100 posts" do
            (0..150).each do |i|
              FactoryGirl.create(:post, time_of_post: Time.now - i)
            end
            get :index, :format => :html
            expect(assigns(:posts).count).to eq(100)
          end
        end
      end

      context "when dashtag page has no owner" do
        before(:each) {allow(User).to receive(:owner_exists?) {false}}
        it "redirects user to create account page" do
          get :index, :format => :html
          expect(response).to redirect_to(users_new_path)
          expect(flash[:notice]).to eq("Welcome to your Dashtag page! To set it up first you need to register below.")
        end
      end
    end

    describe 'GET #get_new_posts' do
      before(:each) do 
        @present = Time.now
        @present_in_miliseconds = (@present.to_f * 1000).to_s
        @present_in_seconds = (@present.to_f)
      end
      it "should convert last_update_time from client to miliseconds and get posts after that time" do
        expect(Post).to receive(:get_new_posts).with(1415474499.122)
        get :get_new_posts, :format => :html, :last_update_time => "1415474499122"
      end
      
      it "should return view of new posts" do
        future = @present + 500
        past = @present - 500
        future_post = FactoryGirl.create(:post, 
          created_at: future, 
          text: "float like a butterfly #word", 
          time_of_post: future, 
          source: 'twitter')
        past_post = FactoryGirl.create(:post, 
          created_at: past, 
          text: "float like a butterfly #word", 
          time_of_post: past, 
          source: 'twitter')
        allow(APIService.instance).to receive(:pull_posts)


        get :get_new_posts, :format => :html, :last_update_time => @present_in_miliseconds
        expect(assigns(:posts).count).to eq(1)
        expect(assigns(:posts).first).to eq(future_post)
      end

      it 'should return status not_modified if there are no new posts' do
        allow(Post).to receive(:get_new_posts).with(instance_of(Float))
        get :get_new_posts, :format => :html, :last_update_time => @present_in_miliseconds
        expect(response.status).to eq(304)
      end
    end

    describe 'GET #get_older_posts' do
      it 'should return a list of older posts' do
        first_post.id, second_post.id = first_post.id, second_post.id
        get :get_older_posts, last_post_id: third_post.id, :format => :html
        expect(assigns(:posts)).to eql([second_post, first_post])
      end

      it 'should return a maximum of 100 posts' do
        (0..150).each { |i| FactoryGirl.create(:post, time_of_post: Time.now - i)}
        get :get_older_posts, last_post_id: third_post.id, :format => :html
        expect(assigns(:posts).count).to eq(100)
      end

      it 'should return status not_modified if there are no more posts left' do
        (0..60).each { |i| FactoryGirl.create(:post, time_of_post: Time.now - i)}
        get :get_older_posts, last_post_id: Post.last.id, :format => :html

        expect(response.status).to eq(304)
      end
    end
  end
end
