class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  def accept
    self.accepted = true
    self.save!
  end
end
