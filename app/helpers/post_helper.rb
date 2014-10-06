module PostHelper
  def add_post_links(post)
    render_post_links embed_instagram_video embed_twitter_content(post) 
  end

  def render_post_links(post) 
    link_urls link_mentions(post)
  end

  def embed_twitter_content(post)
    vine_embed_twitter youtube_embed_twitter link_hashtags_twitter(post)
  end

  def link_mentions(post)
    extract_usernames(post.text).each do |username|
      post.text.gsub! /#{username}\b/i,
                        link_to(username, "//#{post.source}.com/#{username.delete('@')}", target: '_blank')
    end

    post
  end

  def link_hashtags_twitter(post)
    return post if post.source != 'twitter'

    extract_hashtags(post.text).each do |hashtag|
      post.text.gsub! /#{hashtag}\b/i,
        link_to(hashtag, "http://twitter.com/hashtag/#{hashtag[1..-1]}", target: '_blank')
    end

    post
  end

  def link_urls(post)
    return post.text.html_safe if has_instagram_video?(post)

    extract_urls(post.text).each do |url|

      if (post.source == 'twitter' && (has_youtube?(url) || has_vine?(url)))
        return
      end

      post.text.gsub! url,
        link_to(url, url, target: '_blank')
    end

    post.text.html_safe

  end

  def extract_usernames(post_text)
    return [] if post_text.blank?

    post_text.split(' ').map {|word|
      $2 if word.strip =~ /^(\W*)(@\w+)/ && !ends_with_ellipsis?(word)
    }.compact.uniq
  end

  def extract_hashtags(tweet_text)
    return [] if tweet_text.blank?

    tweet_text.split(' ').map {|word|
      $1 if word.strip =~ /^(#\w+)/ && !ends_with_ellipsis?(word)
    }.compact.uniq
  end

  def extract_urls(post_text)
    return [] if post_text.blank?

    post_text.split(' ').keep_if { |word|
      word.start_with?('http') && !ends_with_ellipsis?(word)
    }
  end

  def ends_with_ellipsis?(word)
    return word.end_with?('...') || word.end_with?('…') 
  end

end
