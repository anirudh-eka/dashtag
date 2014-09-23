class CreatePostsTable < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.string :media_url
    	t.string :screen_name
    	t.string :profile_image_url
    	t.string :source
    	t.text :text
    	t.timestamps


    end
  end
end
