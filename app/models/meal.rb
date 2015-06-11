class Meal < ActiveRecord::Base
  validates_presence_of :description, :day, :hour, :calories
end
