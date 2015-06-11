require 'rails_helper'

RSpec.describe Meal, :type => :model do
  it { is_expected.to validate_presence_of(:description)}
  it { is_expected.to validate_presence_of(:day)}
  it { is_expected.to validate_presence_of(:hour)}
  it { is_expected.to validate_presence_of(:calories)}

end
