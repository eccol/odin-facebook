class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :send_notification

  private
  def send_notification
    notification = self.post.user.notifications.create(notification_type: "like", source_user: self.user, post: self.post)
    NotificationsChannel.broadcast_to(self.post.user, body: notification.to_text )
  end
end
