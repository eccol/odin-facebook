class UsersController < ApplicationController
  def index
    @users = User.includes(:profile).all
    @friends = current_user.friends
    @sent_requests = current_user.pending_sent_requests
    @received_requests = current_user.pending_received_requests
  end

  def show
    @user = User.includes(:profile).find(params[:id])
    @friendship = FriendRequest.find_by(sender: current_user, recipient: @user) ||
      FriendRequest.find_by(sender: @user, recipient: current_user)
    @posts = @user.posts
  end
end