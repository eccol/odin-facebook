class FriendRequestsController < ApplicationController
  def create
    request = FriendRequest.new(sender: current_user, recipient: User.find(params[:recipient_id]))
    if request.save
      redirect_to users_path, notice: "Request sent!"
    else
      redirect_to users_path, alert: "Request failed to send."
    end
  end
end