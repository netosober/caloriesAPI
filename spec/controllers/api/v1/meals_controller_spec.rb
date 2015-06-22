require 'rails_helper'

RSpec.describe Api::V1::MealsController, type: :controller do
  render_views
  before(:each) do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  describe "GET #show" do
    before(:each) do
      @meal = FactoryGirl.create(:salad, user: @user)
      get :show, id: @meal.id
    end

    it "responds with 200" do
      expect(response.status).to be 200
    end

    it "get item" do
      expect(json_response[:meal][:description]).to eq(@meal.description)
    end
  end

  describe "GET #index" do
    before(:each) do
      FactoryGirl.create_list(:salad, 2, user: @user)
      FactoryGirl.create_list(:soup, 3, user: @user)
      @meals = Meal.all
      get :index
    end
    it "responds with 200" do
      expect(response.status).to be 200
    end
    it "gets all items" do
      expect(json_response[:meals].count).to eq(@meals.count)
    end
  end

  describe "POST #create" do
    context "with valid meal" do
      before(:each) do
        @meal_attr = FactoryGirl.attributes_for(:salad)
        post :create, meal: @meal_attr
      end

      it "responds with 201" do
        expect(response.status).to be 201
      end

      it "creates new meal" do
        lastMeal = Meal.last
        expect(lastMeal.description).to eq(@meal_attr[:description])
      end

      it "returns new meal" do
        expect(json_response[:meal][:description]).to eq(@meal_attr[:description])
      end
    end

    context "with invalid meal" do
      before(:each) do
        @meal_attr = FactoryGirl.attributes_for(:salad, description: nil )
        post :create, meal: @meal_attr
      end

      it "responds with 422" do
        expect(response.status).to be 422
      end

      it "returns error" do
        expect(json_response[:description]).to include("can't be blank")
      end
    end
  end

  describe "PUT #update" do
    context "with valid meal" do
      before(:each) do
        @meal = FactoryGirl.create(:salad, :user => @user)
        @meal_attr = FactoryGirl.attributes_for(:salad, calories: 2000 )
        put :update, :id => @meal.id, :meal=> @meal_attr
        @meal.reload
      end

      it "responds with 200" do
        expect(response.status).to be 200
      end

      it "updates meal" do
        expect(@meal.calories).to eq(@meal_attr[:calories])
      end

      it "returns updated meal" do
        expect(json_response[:meal][:calories]).to eq(@meal_attr[:calories])
      end
    end

    context "with invalid meal" do
      before(:each) do
        @meal = FactoryGirl.create(:salad, :user => @user)
        @meal_attr = FactoryGirl.attributes_for(:salad, calories: nil )
        put :update, :id => @meal.id, :meal=> @meal_attr
        @meal.reload
      end

      it "responds with 422" do
        expect(response.status).to be 422
      end

      it "doesn't updates meal" do
        expect(@meal.calories).not_to eq(nil)
      end

      it "returns error" do
        expect(json_response[:calories]).to include("can't be blank")
      end
    end

  end

  describe "DELETE #destroy" do
    before(:each) do
      @meal = FactoryGirl.create(:soup, :user => @user)
      delete :destroy, :id => @meal.id
    end

    it "responds with 204" do
      expect(response.status).to be 204
    end

    it "returns nothing" do
      expect(response.body).to be_empty
    end

    it "meal is destroyed" do
      expect(Meal.all.count).to be 0
    end

  end
end
