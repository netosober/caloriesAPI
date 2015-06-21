require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { is_expected.to validate_presence_of :role }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :calories_limit }
end
