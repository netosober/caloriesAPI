class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

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
    @user = User.find(params[:id])
    render json: @user, status: 200
  end
end
