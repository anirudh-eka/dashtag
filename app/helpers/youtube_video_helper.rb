module YoutubeVideoHelper
  def youtube_embed_twitter(tweet_text)
    video_id = youtube_extract_id(tweet_text)

    return tweet_text if video_id.blank?

    embed_code = youtube_embed_code(video_id)

    tweet_text.
      gsub(%r{(\ *https*:)*(//)*youtu.be/#{video_id}\ *}, embed_code).
      gsub(%r{\ *(https*:)*(//)*(www.)*youtube.com/watch\?v=(.*)\ *}, embed_code)
  end

  def youtube_image_url(video_id)
    "https://i.ytimg.com/vi/#{video_id}/hqdefault.jpg"
  end

  def youtube_embed_url(video_id) 
    "//www.youtube.com/embed/#{video_id}"
  end

  def youtube_embed_code(video_id) 
    %{ <iframe width="100%" height="" src="#{youtube_embed_url video_id}" frameborder="0" allowfullscreen></iframe> }
  end

  def youtube_flash_url(video_id, secure=nil)
    protocol = secure ? 'https' : 'http'
    "#{protocol}://www.youtube.com/v/#{video_id}"
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

  def youtube_embed_facebook(post_content)
    return post_content unless has_youtube?(post_content)

    doc = Nokogiri::HTML.fragment(post_content)

    doc.css("a").each do |link|
      link.remove if link.content =~ /^http.*youtu/
    end

    img = doc.css("a img").first

    return doc.to_html if img.nil?

    link = img.parent

    video_id = youtube_extract_id(post_content)

    return doc.to_html if video_id.blank?

    iframe = Nokogiri::HTML.fragment(youtube_embed_code(video_id))
    link.add_next_sibling iframe
    link.remove

    doc.to_html.
      gsub(/^(\s*\<br\>\s*)*/, '')
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
