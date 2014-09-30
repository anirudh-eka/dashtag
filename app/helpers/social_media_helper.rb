module SocialMediaHelper
  def externalize_links(html)
    doc = Nokogiri::HTML.fragment(html)

    doc.css("a").each do |link|
      link["target"] = "_blank"
    end

    doc.to_html
  end

  def video_link?(url)
    url = url.to_s

    has_youtube?(url)
  end
  # || has_vimeo?(url)
end
