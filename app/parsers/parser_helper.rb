module ParserHelper
  def self.text_has_censored_words(text)
  	return false if ENV["CENSORED_WORDS"] == "" || ENV["CENSORED_WORDS"] == nil
    (text && text.match(/.*(#{ENV["CENSORED_WORDS"]}).*/i))
  end

  def self.user_is_censored(screen_name)
  	return false if ENV["CENSORED_USERS"] == "" || ENV["CENSORED_USERS"] == nil
    (screen_name && screen_name.match(/.*(#{ENV["CENSORED_USERS"]}).*/i))   
  end
end