require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_presence_of :role }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :calories_limit }
end
