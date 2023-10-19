class FriendRequestsController < ApplicationController
  def create
    request = FriendRequest.new(sender: current_user, recipient: User.find(params[:recipient_id]))
    if request.save
      redirect_to users_path, notice: "Request sent!"
    else
      redirect_to users_path, alert: "Request failed to send."
    end
  end

  def update
    request = FriendRequest.find(params[:id])
    request.accept
    redirect_to user_path(request.sender.id), notice: "You are now friends with #{request.sender.profile.name}"
  end
end