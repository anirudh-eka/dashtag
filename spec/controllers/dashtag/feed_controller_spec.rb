require 'spec_helper'

module Dashtag
  describe FeedController do
    let(:second_post) { FactoryGirl.create(:post, created_at: Time.now, text: "float like a butterfly", time_of_post: Time.now) }
    let(:first_post) { FactoryGirl.create(:post, created_at: Time.now - 1, text: "floated like a butterfly", time_of_post: Time.now - 1) }
    let(:third_post) { FactoryGirl.create(:post, created_at: Time.now + 1, text: "will float like a butterfly", time_of_post: Time.now + 1) }

    before do
      @routes = Engine.routes
    end

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
      context "with JSON request" do
        it "should convert last_update_time from client to miliseconds and get posts after that time" do
          expect(Post).to receive(:get_new_posts).with(1415474499.122)
          get :index, :format => :json, :last_update_time => "1415474499122"
        end
        it "should render hashtag links for new twitter posts" do
          future = Time.now + 1
          post = FactoryGirl.create(:post, created_at: future, text: "float like a butterfly #word", time_of_post: future, source: 'twitter')
          allow(APIService.instance).to receive(:pull_posts)
          get :index, :format => :json
          expect(assigns(:posts).first.text).to eq('float like a butterfly <a target="_blank" href="http://twitter.com/hashtag/word">#word</a>')
        end
      end
    end

    describe 'GET #get_next_page' do
      it 'should return a list of older posts' do
        first_post.id, second_post.id = first_post.id, second_post.id
        get :get_next_page, last_post_id: third_post.id, :format => :json
        expect(assigns(:posts)).to eql([second_post, first_post])
      end

      it 'should return a maximum of 100 posts' do
        (0..150).each { |i| FactoryGirl.create(:post, time_of_post: Time.now - i)}
        get :get_next_page, last_post_id: third_post.id, :format => :json
        expect(assigns(:posts).count).to eq(100)
      end

      it 'should return status not_modified if there are no more posts left' do
        (0..60).each { |i| FactoryGirl.create(:post, time_of_post: Time.now - i)}
        get :get_next_page, last_post_id: Post.last.id, :format => :json

        expect(response.status).to eq(304)
      end

      it "should render hashtag links for posts" do
        past = Time.now - 3
        past_post = FactoryGirl.create(:post, created_at: past, text: "float like a butterfly #word", time_of_post: past, source: 'twitter')
        allow(Post).to receive(:next_posts) { [past_post] }

        get :get_next_page, last_post_id: past_post.id, :format => :json

        expect(assigns(:posts).first.text).to eq('float like a butterfly <a target="_blank" href="http://twitter.com/hashtag/word">#word</a>')
      end
    end
  end
end
