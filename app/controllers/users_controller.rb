class UsersController < ApplicationController
  def index
    @users = User.includes(:profile).all
  end

  def show
    @user = User.includes(:profile).find(params[:id])
    @posts = @user.posts
  end
end