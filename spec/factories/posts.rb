FactoryGirl.define do
	factory :post do
		screen_name "cassius_clay"
  	profile_image_url "stuf.com"
  	created_at Time.now - 2
  	time_of_post Time.now - 5
  	source "twitter"
  	media_url "some media url"
  	text "float like a butterfly"
  	post_id "12345"

    factory :random_post do
      screen_name {Faker::Lorem.words.join("_")}
    end
	end
end
