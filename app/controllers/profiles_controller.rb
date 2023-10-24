class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.profile.update(profile_params)
      redirect_to profile_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:name, :birthday, :city)
  end
end
