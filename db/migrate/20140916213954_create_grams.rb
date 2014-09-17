class CreateGrams < ActiveRecord::Migration
  def change
    create_table :grams do |t|
    	t.string :media_url
    	t.string :screen_name
    	t.string :profile_image_url
    	t.text :text
    	t.timestamps


    end
  end
end
