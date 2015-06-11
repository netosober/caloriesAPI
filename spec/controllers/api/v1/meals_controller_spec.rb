require 'rails_helper'

RSpec.describe Api::V1::MealsController, type: :controller do
  describe "GET" do
    let(:meal) { FactoryGirl.create(:meal) }
    it "get item" do
      get :show, id: meal.id

      expect(response).to be_success
      expect(json_response[:description]).to eq(meal.description)
    end
  end
end
