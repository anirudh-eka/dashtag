module Dashtag
  module ParserHelper
    def self.text_has_censored_words(text)
    	return false if SettingStore.censored_words.empty?
      (text && text.match(/.*(#{SettingStore.censored_words.join("|")}).*/i))
    end

    def self.user_is_censored(screen_name)
      SettingStore.censored_users.include?(screen_name)
    end
  end
end
