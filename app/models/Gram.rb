class Gram < ActiveRecord::Base
  validates_presence_of :screen_name, :created_at, :profile_image_url, :media_url

  # def as_json(options={})
  #   super.as_json().merge({created_at_formatted: created_at_formatted})
  # end

  # def created_at_formatted
  #   created_at.strftime("%a %b %d %l:%M %p")
  # end

  def ==(gram)
    screen_name == gram.screen_name && profile_image_url == gram.profile_image_url && created_at == gram.created_at && media_url == gram.media_url
  end
end