module Dashtag
  class User < ActiveRecord::Base
    before_save { email.downcase! }
  	validates_presence_of :username
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  	validates :password, length: { minimum: 6 }
    validate :there_can_only_be_one_user

  	has_secure_password

    def self.owner_exists?
      !User.first.nil?
    end

    def there_can_only_be_one_user
      if User.owner_exists? && User.first != self
        errors[:base] << "A user has already been registered for this Dashtag page."
      end
    end

  end
end
