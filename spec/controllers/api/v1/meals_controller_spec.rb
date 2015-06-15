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
        @meal_attr = FactoryGirl.attributes_for(:salad)
        post :create, meal: @meal_attr
      end

      it "responds with 200" do
        expect(response).to be_success
      end

      it "creates new meal" do
        lastMeal = Meal.last
        expect(lastMeal.description).to eq(@meal_attr[:description])
      end

      it "returns new meal" do
        expect(json_response[:description]).to eq(@meal_attr[:description])
      end
    end

    context "with invalid meal" do
      before(:each) do
        @meal_attr = FactoryGirl.attributes_for(:salad, description: nil )
        post :create, meal: @meal_attr
      end

      it "responds with 422" do
        expect(response).not_to be_success
      end

      it "returns error" do
        expect(json_response[:description]).to include("can't be blank")
      end
    end
  end

  describe "PUT #update" do
    context "with valid meal" do
      before(:each) do
        @meal = FactoryGirl.create(:salad)
        @meal_attr = FactoryGirl.attributes_for(:salad, calories: 2000 )
        put :update, :id => @meal.id, :meal=> @meal_attr
        @meal.reload
      end

      it "responds with 200" do
        expect(response).to be_success
      end

      it "updates meal" do
        expect(@meal.calories).to eq(@meal_attr[:calories])
      end

      it "returns updated meal" do
        expect(json_response[:calories]).to eq(@meal_attr[:calories])
      end
    end

    context "with invalid meal" do
      before(:each) do
        @meal = FactoryGirl.create(:salad)
        @meal_attr = FactoryGirl.attributes_for(:salad, calories: nil )
        put :update, :id => @meal.id, :meal=> @meal_attr
        @meal.reload
      end

      it "responds with 422" do
        expect(response).not_to be_success
      end

      it "doesn't updates meal" do
        expect(@meal.calories).not_to eq(nil)
      end

      it "returns error" do
        expect(json_response[:calories]).to include("can't be blank")
      end
    end

  end
end
