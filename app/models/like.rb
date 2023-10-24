class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :send_notification

  private
  def send_notification
    self.post.user.notifications.create(notification_type: "like", source_user: self.user, post: self.post)
  end
end
