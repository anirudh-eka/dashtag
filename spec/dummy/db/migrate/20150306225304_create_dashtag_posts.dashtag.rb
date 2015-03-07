# This migration comes from dashtag (originally 20150109000249)
class CreateDashtagPosts < ActiveRecord::Migration
  def change
    create_table :dashtag_posts do |t|
      t.string   :media_url
      t.string   :screen_name
      t.string   :profile_image_url
      t.string   :source
      t.datetime :time_of_post
      t.text     :text
      t.string   :post_id
      t.timestamps null: false
    end
  end
end
