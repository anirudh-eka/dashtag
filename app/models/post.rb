class Post < ActiveRecord::Base
	validates_presence_of :screen_name, :created_at,
	 					:profile_image_url, :source

	validates_uniqueness_of :screen_name, scope: :created_at


  def as_json(options={})
    super.as_json().merge({created_at_formatted: created_at_formatted})
  end

  def created_at_formatted
    created_at.strftime("%a %b %d %l:%M %p")
  end

	def ==(post)
      text == post.text &&
       screen_name == post.screen_name &&
       created_at == post.created_at &&
       media_url == post.media_url &&
       source == post.source
  end


end