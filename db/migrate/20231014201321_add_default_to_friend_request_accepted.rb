class AddDefaultToFriendRequestAccepted < ActiveRecord::Migration[7.0]
  def change
    change_column_default :friend_requests, :accepted, from: nil, to: false
  end
end
