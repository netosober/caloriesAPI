class Meal < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :description, :day, :hour, :calories, :user
  scope :sorted, -> { order(:day, :hour) }
end
