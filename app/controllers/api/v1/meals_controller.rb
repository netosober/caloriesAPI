class Api::V1::MealsController < ApplicationController
  def index
    meals = Meal.all
    render json: meals, status: 200
  end

  def show
    meal = Meal.find(params[:id])
    render json: meal, status: 200
  end
end
