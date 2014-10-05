module VineVideoHelper
  def vine_embed_twitter(tweet_post)
    return tweet_post if tweet_post.source != 'twitter'

    tweet_text = tweet_post.text
    video_id = vine_extract_id(tweet_text)

    return tweet_post if video_id.blank?

    tweet_text.gsub! %r{(https*:*//*)vine.co/v/#{video_id}}, vine_embed_code(video_id)

    tweet_post
  end

  def vine_extract_url(text)
   text.split(' ').each {|word|
      return $1 if word.match %r{//vine.co/v/(\S+)}
    }
    nil
  end

  def vine_embed_code(video_id)
    %{ <iframe src="https://vine.co/v/#{video_id}/embed/simple" width="100%" frameborder="0"></iframe> }
  end

  def vine_extract_id(text)
   text.split(' ').each {|word|
      return $1 if word.match %r{//vine.co/v/(\S+)}
    }
    nil
  end

  def has_vine?(text)
    return false if text.blank?
    !!(text =~ /vine.co/)
  end
end
