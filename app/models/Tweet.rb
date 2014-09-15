class Tweet < ActiveRecord::Base
  validates_presence_of :text, :screen_name, :created_at, :profile_image_url
  validates_uniqueness_of :text


  def as_json(options={})
    super.as_json().merge({created_at_formatted: created_at_formatted})
  end

  def created_at_formatted
    created_at.strftime("%a %b %d %l:%M %p")
  end

  def ==(tweet)
    text == tweet.text && screen_name == tweet.screen_name && created_at == tweet.created_at && media_url == tweet.media_url
  end
end