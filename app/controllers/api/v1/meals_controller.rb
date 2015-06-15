class Api::V1::MealsController < ApplicationController
  def index
    @meals = Meal.all
    render json: @meals, status: 200
  end

  def show
    @meal = Meal.find(params[:id])
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

  private
  def meal_params
    params.require(:meal).permit(:description, :day, :hour, :calories)
  end
end
