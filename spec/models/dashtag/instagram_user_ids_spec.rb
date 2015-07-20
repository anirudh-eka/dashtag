require 'spec_helper'

module Dashtag
  describe InstagramUserIds do
    it "should stringify correctly for users" do 
      users = InstagramUserIds.new([1, 2])
      expect(users.to_ui_format).to eq("1, 2")
    end

    it "should parse user id string into user ids" do
      users_string = "1, 2, 3"
      users = InstagramUserIds.parse (users_string)
      expect(users).to eq(InstagramUserIds.new([1, 2, 3]))
    end

    it "should strip nonessential whitespace from users string when converting into InstagramUserIds" do
      users_string = "\n1, 3, 4\n\n"
      expect(InstagramUserIds.parse (users_string)).to eq([1, 3, 4])
    end

    it "should dehydrate itself" do
      users_list = [4, 5]
      users = InstagramUserIds.new(users_list)
      expect( users.dehydrate ).to eq(users_list.to_json)
    end

    it "should hydrate a InstagramUserIds" do
      users = InstagramUserIds.new([8, 7])
      expect( InstagramUserIds.hydrate(users.dehydrate)).to eq(InstagramUserIds.new([8, 7]))
    end
  end
end
