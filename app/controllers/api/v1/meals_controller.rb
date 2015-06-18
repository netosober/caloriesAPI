class Api::V1::MealsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_meal, only: [:show, :update, :destroy]

  def index
    @meals = current_user.meals
  end

  def show
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    if @meal.save
      render json: @meal, status: 201
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

  def destroy
    @meal.delete

    head :no_content
  end

  private

  def get_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:description, :day, :hour, :calories)
  end
end
