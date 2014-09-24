module TwitterHelper
  def add_tweet_links(tweet_text, urls = [])
    link_hashtags link_usernames embed_tweet_videos restore_twitter_links(tweet_text, urls || [])
  end

  def embed_tweet_videos(tweet_text)
    youtube_embed_twitter vimeo_embed_twitter vine_embed_twitter tweet_text
  end

  def link_usernames(tweet_text)
    extract_usernames(tweet_text).each do |username|
      tweet_text.gsub! username,
        link_to(username, "//twitter.com/#{username}", target: '_blank')
    end

    tweet_text.html_safe
  end

  def link_hashtags(tweet_text)
    extract_hashtags(tweet_text).each do |hashtag|
      tweet_text.gsub! hashtag,
        link_to(hashtag, "//twitter.com/hashtag/#{hashtag[1..-1]}", target: '_blank')
    end

    tweet_text.html_safe
  end

  def extract_usernames(tweet_text)
    return [] if tweet_text.blank?

    tweet_text.split(' ').map {|word|
      $2 if word.strip =~ /^(\W*)(@\w+)/
    }.compact.uniq
  end

  def extract_hashtags(tweet_text)
    return [] if tweet_text.blank?

    tweet_text.split(' ').map {|word|
      $1 if word.strip =~ /^(#\w+)/
    }.compact.uniq
  end

  def restore_twitter_links(tweet_text, urls)
    urls.each do |url|
      replace_text =
        video_link?(url.expanded_url) ?
        url.expanded_url.to_s :
        link_to(url.display_url.to_s, url.expanded_url.to_s, target: '_blank')

      tweet_text.gsub! url.url.to_s, replace_text
    end

    tweet_text
  end

end
