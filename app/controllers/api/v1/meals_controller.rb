class Api::V1::MealsController < ApplicationController
  before_action :get_meal, only: [:show, :update]

  def index
    @meals = Meal.all
    render json: @meals, status: 200
  end

  def show
    render json: @meal, status: 200
  end

  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      render json: @meal, status: 200
    else
      render json: @meal.errors, status: 422
    end
  end

  def update
    if @meal.update(meal_params)
      render json: @meal, status: 200
    else
      render json: @meal.errors, status: 422
    end
  end

  private

  def get_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:description, :day, :hour, :calories)
  end
end
