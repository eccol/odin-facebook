class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validate :cannot_friend_self
  validate :does_not_exist, on: :create

  def accept
    self.accepted = true
    self.save!
  end

  private
  def cannot_friend_self
    errors.add(:recipient_id, "Cannot friend self") if sender_id == recipient_id
  end

  def does_not_exist
    # "not valid without sender" test breaks when it tries to call nil.pending_friends
    # Therefore adding a manual check here
    if self.sender.nil?
      errors.add(:sender, "missing")
      return
    end
    if self.sender.pending_friends.include?(self.recipient)
      errors.add(:base, "Friend request already exists")
    end
  end
end
