class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, only: [:show, :update, :destroy]

  def index
    if current_user.role == 'normal'
      @user = current_user
      render json: @user, status: 200
    elsif current_user.role == 'admin' || current_user.role == 'manager'
      @users = User.all
      render json: @users, status: 200
    else
      render status: 401
    end
  end

  def show
    render json: @user, status: 200
  end

  def create
    if current_user.role == 'normal'
      render json: { error: 'unauthorized' }, status: 401
    else
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: 201
      else
        render json: @user.errors, status: 422
      end
    end
  end


    private

    def get_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :role, :password, :password_confirmation)
    end
end
