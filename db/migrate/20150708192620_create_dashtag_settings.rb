class CreateDashtagSettings < ActiveRecord::Migration
  def change
    create_table :dashtag_settings do |t|
      t.string :name, null: false
      t.string :value, null: true
      t.timestamps null: false
    end
  end
end
