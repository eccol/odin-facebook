require 'rails_helper'

RSpec.describe User, type: :model do
  let(:sending_user) { User.create!(email: "a@a.a", password: "abcabc") }
  let(:receiving_user) { User.create!(email: "b@b.b", password: "cbacba") }

  context "#friends" do
    it "returns accepted friend requests" do
      request = FriendRequest.create(sender: sending_user, recipient: receiving_user)
      request.accept
      expect(sending_user.friends).to include(receiving_user)
    end

    it "does not return unaccepted requests" do
      request = FriendRequest.create(sender: sending_user, recipient: receiving_user)
      expect(sending_user.friends).not_to include(receiving_user)
    end
  end
end
