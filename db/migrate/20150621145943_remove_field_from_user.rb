class RemoveFieldFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :role, :string
    remove_column :users, :name, :string
    remove_column :users, :calories_limit, :string
  end
end
