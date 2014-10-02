class ParserHelper
  def self.text_has_censored_words(text)
    (text && text.match(/.*(#{ENV["CENSORED_WORDS"]}).*/i))
  end

  def self.user_is_censored(screen_name)
    (screen_name && screen_name.match(/.*(#{ENV["CENSORED_USERS"]}).*/i))   
  end
end