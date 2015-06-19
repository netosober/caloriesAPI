class ChangeHourToMeal < ActiveRecord::Migration
  def change
    change_column :meals, :hour, :string
  end
end
