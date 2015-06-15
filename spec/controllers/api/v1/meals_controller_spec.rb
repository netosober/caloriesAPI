require 'rails_helper'

RSpec.describe Api::V1::MealsController, type: :controller do
  describe "GET #show" do
    before(:each) do
      @meal = FactoryGirl.create(:salad)
      get :show, id: @meal.id
    end

    it "responds with 200" do
      expect(response).to be_success
    end

    it "get item" do
      expect(json_response[:description]).to eq(@meal.description)
    end
  end

  describe "GET #index" do
    before(:each) do
      FactoryGirl.create_list(:salad, 2)
      FactoryGirl.create_list(:soup, 3)
      @meals = Meal.all
      get :index
    end
    it "responds with 200" do
      expect(response).to be_success
    end
    it "gets all items" do
      expect(json_response.count).to eq(@meals.count)
    end
  end

  describe "POST #create" do
    context "with valid meal" do
      before(:each) do
        @meal = FactoryGirl.attributes_for(:salad)
        post :create, meal: @meal
      end

      it "responds with 200" do
        expect(response).to be_success
      end

      it "creates new meal" do
        lastMeal = Meal.last
        expect(lastMeal.description).to eq(@meal[:description])
      end

      it "returns new meal" do
        expect(json_response[:description]).to eq(@meal[:description])
      end
    end

    context "with invalid meal" do
      before(:each) do
        @meal = FactoryGirl.attributes_for(:salad, description: nil )
        post :create, meal: @meal
      end

      it "responds with 422" do
        expect(response).not_to be_success
      end

      it "returns new meal" do
        expect(json_response[:description]).to include("can't be blank")
      end
    end
  end
end
