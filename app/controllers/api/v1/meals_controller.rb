class Api::V1::MealsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_meal, only: [:show, :update, :destroy]

  def index
    @meals = current_user.meals.sorted
  end

  def show
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    if @meal.save
      render :show, status: 201
    else
      render json: @meal.errors, status: 422
    end
  end

  def update
    if @meal.user == current_user
      if @meal.update(meal_params)
        render :show
      else
        render json: @meal.errors, status: 422
      end
    else
      render_unauthorized "can't edit meal that belongs to users"
    end
  end

  def destroy
    if @meal.user == current_user
      @meal.delete
      head :no_content
    else
      render_unauthorized "can't delete meal that belongs to users"
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
