class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.integer :calories_limit
      t.string :role

      t.timestamps null: false
    end
  end
end
