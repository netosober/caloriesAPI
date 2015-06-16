class Api::V1::UsersController < ApplicationController
  def index
    @user = current_user
    render json: @user, status: 200
  end
end
