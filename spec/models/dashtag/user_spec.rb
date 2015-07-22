require 'spec_helper'

module Dashtag
  describe User do
    it { should have_secure_password }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }

    let(:user) {User.create(username: "dashy", email: "dashy@tag.co", password: "password")}
    
    it "should accept valid email addresses" do

	    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
	                         first.last@foo.jp alice+bob@baz.cn]
	    valid_addresses.each do |valid_address|
	      user.email = valid_address
	      expect(user.valid?).to be_truthy
	    end
    end

    it "should reject invalid email addresses" do

      valid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com  foo@bar..com]
      valid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user.valid?).to be_falsy
      end
    end

    it "should save email addresses as lower-case" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      user.email = mixed_case_email
      user.save
      expect(user.email).to eq(mixed_case_email.downcase)
    end

    it "should not allow more than one user to register" do
      user.save
      second_user = User.new(username: "tooslow", email: "tooslow@register.ing", password: "password")

      expect(second_user.valid?).to be_falsy
    end
  end
end
