module Dashtag
  FactoryGirl.define do
  	factory :post, class: Dashtag::Post do
  		screen_name "cassius_clay"
    	profile_image_url "http://fc00.deviantart.net/fs23/i/2007/334/a/9/Dash_Tag_by_scootinstar28.jpg"
    	created_at Time.now - 2
    	time_of_post Time.now - 5
    	source "twitter"
    	media_url "http://fc00.deviantart.net/fs23/i/2007/334/a/9/Dash_Tag_by_scootinstar28.jpg"
    	text "float like a butterfly"
    	post_id "12345"

      factory :random_post do
        screen_name {Faker::Lorem.words.join("_")}
      end
  	end
  end
end
