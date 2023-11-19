class FriendRequestsController < ApplicationController
  def create
    sender = current_user
    recipient = User.find(params[:recipient_id])
    request = FriendRequest.new(sender: sender, recipient: recipient)
    if request.save
      UserMailer.with(sender: sender, recipient: recipient).friend_request_email.deliver_later
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

  def destroy
    request = FriendRequest.find(params[:id])
    request.destroy
    redirect_to users_path
  end
end