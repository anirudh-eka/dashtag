module Dashtag
  module PostHelper
    def add_post_links(post)
      render_post_links embed_instagram_video embed_twitter_content(post)
    end

    def render_post_links(post)
      link_urls link_mentions(post)
    end

    def embed_twitter_content(post)
      return post if post.source != 'twitter'

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

        post.text.gsub! url, link_to(url, url, target: '_blank')
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

    def vine_embed_twitter(tweet_post)
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
      %{ <iframe src="https://vine.co/v/#{video_id}/embed/simple" width="320" height="320" class="vine-video" frameborder="0"></iframe> }
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

    private

    def ends_with_ellipsis?(word)
      return word.end_with?('...') || word.end_with?('…')
    end

  end
end
