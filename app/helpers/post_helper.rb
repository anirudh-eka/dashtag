module PostHelper
  def add_post_links(post)
    link_urls link_usernames youtube_embed_twitter link_hashtags_twitter(post)
  end

  def link_usernames(post)
    extract_usernames(post.text).each do |username|
      if post.source == 'twitter'
        post.text.gsub! /#{username}\b/i,
                        link_to(username, "//#{post.source}.com/#{username}", target: '_blank')
      else
        post.text.gsub! /#{username}\b/i,
                        link_to(username, "//#{post.source}.com/#{username.delete('@')}", target: '_blank')
      end
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
    extract_urls(post.text).each do |url|

      if (post.source == 'twitter' && has_youtube?(url))
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
      $2 if word.strip =~ /^(\W*)(@\w+)/ && !word.end_with?('…')
    }.compact.uniq
  end

  def extract_hashtags(tweet_text)
    return [] if tweet_text.blank?

    tweet_text.split(' ').map {|word|
      $1 if word.strip =~ /^(#\w+)/ && !word.end_with?('…')
    }.compact.uniq
  end

  def extract_urls(post_text)
    return [] if post_text.blank?

    post_text.split(' ').keep_if { |word|
      word.start_with?('http') && !word.end_with?('…')
    }
  end
end
