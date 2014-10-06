module InstagramVideoHelper
  def embed_instagram_video(instagram_post)
    return instagram_post if instagram_post.source != 'instagram' || !has_instagram_video?(instagram_post)

    instagram_post.text << instagram_embed_code(instagram_post.post_id)

    instagram_post
  end

  def instagram_embed_code(video_id)
    %{ <iframe src="//instagram.com/p/#{video_id}/embed/" width="306" height="355" frameborder="0"></iframe> }
  end

  def has_instagram_video?(instagram_post)
    return instagram_post.source == "instagram" && instagram_post.media_url.nil?
  end
end
