module ParserHelper
  def self.text_has_censored_words(text)
  	return false if EnvironmentService.censored_words == "" || EnvironmentService.censored_words == nil
    (text && text.match(/.*(#{EnvironmentService.censored_words}).*/i))
  end

  def self.user_is_censored(screen_name)
  	return false if EnvironmentService.censored_users == "" || EnvironmentService.censored_users == nil
    (screen_name && screen_name.match(/.*(#{EnvironmentService.censored_users}).*/i))
  end
end
