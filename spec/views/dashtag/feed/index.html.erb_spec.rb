require 'spec_helper'

module Dashtag
	describe 'dashtag/feed/index.html.erb' do
		# include PostHelper
    before do
      controller.singleton_class.class_eval do
         extend PostHelper
        protected
          def add_post_links (post)
            # true
            # add_post_links post
            PostHelperMethods.add_post_links(post)
          end
          helper_method :add_post_links
      end
    end

    before(:each) do
    	@settings = Settings.load_settings
    end

	  it 'displays post screenname correctly' do
	    @posts =  FactoryGirl.create_list(:random_post, 3)

	    render

		@posts.each do |post|
	    	rendered.should have_text(post.screen_name)
	    end
	  end

	  it 'displays links to twitter posts' do
	    @posts =  FactoryGirl.create_list(:random_post, 3)
	    render
		@posts.each do |post|
	    	rendered.should have_xpath("//a[contains(.,#{post.screen_name})]")
	    end
	  end

	end
	class PostHelperMethods
		extend PostHelper
	end
end


