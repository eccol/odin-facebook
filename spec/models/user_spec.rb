require 'rails_helper'

RSpec.describe User, type: :model do
  context "#friends" do
    it "returns accepted friend requests" do
      sender = User.create
      recipient = User.create
      request = FriendRequest.create(sender: sender, recipient: recipient)
      request.accept
      expect(sender.friends).to include(recipient)
    end

    it "does not return unaccepted requests" do
      sender = User.create
      recipient = User.create
      request = FriendRequest.create(sender: sender, recipient: recipient)
      expect(sender.friends).to include(recipient)
    end
  end
end
