class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :text
      t.string :screen_name
      t.string :created_at
      t.string :profile_image_url
      t.string :media_url

      t.timestamps
    end
  end
end
