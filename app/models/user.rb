class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_friend_requests, foreign_key: "sender_id", class_name: "FriendRequest", dependent: :destroy
  has_many :received_friend_requests, foreign_key: "recipient_id", class_name: "FriendRequest", dependent: :destroy

  has_many :posts, dependent: :destroy
  has_one :profile, dependent: :destroy

  def friends
    (FriendRequest.where(sender: self).where(accepted: true).map(&:recipient) +
      FriendRequest.where(recipient: self).where(accepted: true).map(&:sender))
      .uniq
  end

  def pending_friends
    (FriendRequest.where(recipient: self).where(accepted: false).map(&:sender) +
    FriendRequest.where(sender: self).where(accepted: false).map(&:recipient))
      .uniq
  end
end
