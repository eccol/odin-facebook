class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :source_user, class_name: "User"

  def to_text
    source_user_name = self.source_user.profile.name

    case self.notification_type
    when "friend_request"
      "#{source_user_name} send you a friend request"
    when "like"
      "#{source_user_name} liked your post"
    end
  end
end
