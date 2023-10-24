module NotificationsHelper
  def notification_to_text(notification)
    source_user_name = notification.source_user.profile.name

    case notification.notification_type
    when "friend_request"
      "#{source_user_name} send you a friend request"
    when "like"
      "#{source_user_name} liked your post"
    end
  end
end