class GramFactory

	def self.make_grams(parsed_response)
		parsed_response["data"].each do |gram|

			unless gram["caption"].nil?
				text = gram["caption"]["text"]
			end

			unless gram["images"].nil?
				unless gram["images"]["standard_resolution"].nil?
					media_url = gram["images"]["standard_resolution"]["url"]
				end
			end

			screen_name = gram["user"]["username"]
			profile_image_url = gram["user"]["profile_picture"]
			created_at = DateTime.strptime(gram["created_time"], "%s")

			begin
			Gram.create!(
				text: text,
				screen_name: screen_name,
				media_url: media_url,
				profile_image_url: profile_image_url,
				created_at: created_at
				)
			rescue 
			end

		end
	Gram.order(created_at: :desc).first

	end
end