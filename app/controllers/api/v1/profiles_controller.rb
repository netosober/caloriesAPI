class Api::V1::ProfilesController < ApplicationController
  before_action :get_profile, only: [:show, :update, :destroy]

  def index
    if current_user.profile.role == "normal"
      @profiles = [ current_user.profile ]
    else
      @profiles = Profile.all
    end
  end

  def show
    if current_user.profile.role == "normal" && current_user.profile.id != @profile.id
      render_unauthorized "can't show profiles from other users"
    else
      @profile
    end
  end

  def update
    if current_user.profile.role == "normal" && current_user.profile.id != @profile.id
      render_unauthorized "can't update other profiles"
    elsif @profile.role != profile_params[:role] && current_user.profile.role == "normal"
      render_unauthorized "can't change role"
    elsif @profile.role != profile_params[:role] && current_user.profile.role == "manager" && profile_params[:role] == "admin"
      render_unauthorized "can't change role to admin"
    elsif @profile.update(profile_params)
      render :show
    else
      render json: @profile.errors, status: 422
    end
  end


  def destroy
    if current_user.profile.role == "normal" && current_user.profile.id != @profile.id
      render_unauthorized "can't destroy other profiles"
    else
      @profile.user.delete
      @profile.delete
      head :no_content
    end
  end


  private

  def get_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :calories_limit, :role)
  end
end
