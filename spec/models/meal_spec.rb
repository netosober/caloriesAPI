require 'rails_helper'

RSpec.describe Meal, :type => :model do
  it { is_expected.to validate_presence_of(:description)}
  it { is_expected.to validate_presence_of(:day)}
  it { is_expected.to validate_presence_of(:hour)}
  it { is_expected.to validate_presence_of(:calories)}
  describe "#sorted" do
    it "returns ordered meals by day and hour" do
      user = FactoryGirl.create(:user)
      salad1 = FactoryGirl.create(:salad, day: 1.day.ago, user: user)
      salad2 = FactoryGirl.create(:salad, day: 2.days.ago, hour: 10.minute.ago, user: user)
      salad3 = FactoryGirl.create(:salad, day: 2.days.ago, hour: 2.minutes.ago, user: user)

      expect(Meal.sorted.first.id).to eq(salad2.id)
      expect(Meal.sorted.last.id).to eq(salad1.id)
    end
  end
end
