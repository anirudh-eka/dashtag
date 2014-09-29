FactoryGirl.define do
	factory :post do
		screen_name "cassius_clay"
    	profile_image_url "stuf.com"
    	created_at Time.now - 2
    	time_of_post Time.now - 5
    	source "twitter"
    	text "float like a butterfly"
	end
end