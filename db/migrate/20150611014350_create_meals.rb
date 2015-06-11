class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.text :description
      t.date :day
      t.time :hour
      t.integer :calories

      t.timestamps null: false
    end
  end
end
