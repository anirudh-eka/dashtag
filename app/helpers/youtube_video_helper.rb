module YoutubeVideoHelper
  def youtube_embed_twitter(tweet_post)
    tweet_text = tweet_post.text
    video_id = youtube_extract_id(tweet_text)

    return tweet_post if video_id.blank?

    embed_code = youtube_embed_code(video_id)

    tweet_post.text.
      gsub!(%r{(\ *https*:)*(//)*youtu.be/#{video_id}\ *}, embed_code)

    tweet_post.text.
      gsub!(%r{\ *(https*:)*(//)*(www.)*youtube.com/watch\?v=(.*)\ *}, embed_code)

    tweet_post
  end

  def youtube_embed_code(video_id) 
    %{ <div class="youtube-video"><iframe src="//www.youtube.com/embed/#{video_id}" frameborder="0" height="100%" allowfullscreen></iframe></div> }
  end

  def youtube_extract_id(text)
    ignore = '[^?&<"]'
    text.split(' ').each {|word|
      return $1 if word.match(%r{youtu.be/(#{ignore}*)})
      return $1 if word.match(%r{youtube.com/watch\?v=(#{ignore}*)})
      return $1 if word.match(%r{youtube.com/embed/(#{ignore}*)\?*})
    }
    nil
  end

  def has_youtube?(text)
    return false if text.blank?
    !!(
      text.match(%r{youtu.be/([^?&]*)}) ||
      text.match(%r{youtube.com/watch\?v=([^?&]*)}) ||
      text.match(%r{youtube.com/embed/([^?&<]*)\?*})
    )
  end
end
