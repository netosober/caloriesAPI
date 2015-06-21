class Profile < ActiveRecord::Base
  validates_presence_of :role, :name, :calories_limit
  belongs_to :user
end
