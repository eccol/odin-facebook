class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_friend_requests, foreign_key: "sender_id", class_name: "FriendRequest", dependent: :destroy
  has_many :received_friend_requests, foreign_key: "recipient_id", class_name: "FriendRequest", dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :likes
  has_one :profile, dependent: :destroy
  has_many :notifications
  has_many :triggered_notifications, foreign_key: :source_user_id

  accepts_nested_attributes_for :profile

  after_create :send_welcome_email

  def friends
    # Returns an array of User objects the user has accepted friend requests with
    (FriendRequest.where(sender: self).where(accepted: true).map(&:recipient) +
      FriendRequest.where(recipient: self).where(accepted: true).map(&:sender))
      .uniq
  end

  def friends?(user)
    friends.include?(user)
  end

  def pending_friends
    (FriendRequest.where(recipient: self).where(accepted: false).map(&:sender) +
    FriendRequest.where(sender: self).where(accepted: false).map(&:recipient))
      .uniq
  end

  def pending_sent_requests
    FriendRequest.where(sender: self).where(accepted: false).map(&:recipient)
  end

  def pending_received_requests
    FriendRequest.where(recipient: self).where(accepted: false).map(&:sender)
  end

  # I am keeping these methods around in case they become useful
  # But they are not currently used and should be deleted later on if they stay that way
  def friends_ids
    # Returns an array of ids of users the user is friends with
    accepted_requests.pluck(:sender_id, :recipient_id).flatten.uniq.reject { |id| id == self.id }
  end

  def accepted_requests
    # Returns an ActiveRecord_Relation object of accepted friend requests involving the user
    FriendRequest.where("sender_id = :user_id OR recipient_id = :user_id", user_id: self.id).where(accepted: true)
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

end
