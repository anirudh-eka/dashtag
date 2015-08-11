require 'spec_helper'

module Dashtag
  describe SocialUsers do
    it "should stringify correctly for users" do 
      users = SocialUsers.new(["peace", "love"])
      expect(users.to_ui_format).to eq("@peace, @love")
    end

    it "should parse hashtag string into users" do
      users_string = "@yolo, @dance, @christmas"
      users = SocialUsers.parse (users_string)
      expect(users).to eq(SocialUsers.new(['yolo', 'dance', 'christmas']))
    end

    it "should strip nonessential whitespace from users string when converting into SocialUsers" do
      users_string = "\n@yolo, @cool, @stuff\n\n"
      expect(SocialUsers.parse (users_string)).to eq(['yolo', 'cool', 'stuff'])
    end

    it "should dehydrate itself" do
      users_list = ["peace", "love"]
      users = SocialUsers.new(users_list)
      expect( users.dehydrate ).to eq(users_list.to_json)
    end

    it "should hydrate a SocialUsers" do
      users = SocialUsers.new(["peace", "love"])
      expect( SocialUsers.hydrate(users.dehydrate)).to eq(SocialUsers.new(["peace", "love"]))
    end
  end
end
