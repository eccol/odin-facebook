class ProfilesController < ApplicationController
  before_action lambda { resize_avatar(profile_params[:avatar])}, only: [:update]
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
    params.require(:profile).permit(:name, :birthday, :city, :avatar)
  end

  def resize_avatar(image_param)
    return unless image_param

    ImageProcessing::MiniMagick
    .source(image_param)
    .resize_to_fit(100,100)
    .call(destination: image_param.tempfile.path)
  end
end
