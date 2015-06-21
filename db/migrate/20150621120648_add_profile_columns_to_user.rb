class AddProfileColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :calories_limit, :integer
    add_column :users, :name, :string
  end
end
