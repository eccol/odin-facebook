class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validate :does_not_exist, on: :create

  def accept
    self.accepted = true
    self.save!
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
