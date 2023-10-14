require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  let(:sending_user) { User.create }
  let(:receiving_user) { User.create }

  it "is valid with valid attributes" do
    friend_request = FriendRequest.new(sender: sending_user, recipient: receiving_user)
    expect(friend_request).to be_valid
  end

  it "is not valid without a sender" do
    friend_request = FriendRequest.new(recipient: receiving_user)
    expect(friend_request).not_to be_valid
  end

  it "is not valid without a recipient" do
    friend_request = FriendRequest.new(sender: sending_user)
    expect(friend_request).not_to be_valid
  end

  it "is not accepted immediately after creation" do
    friend_request = FriendRequest.new(sender: sending_user, recipient: receiving_user)
    expect(friend_request.accepted).to be false
  end

  it "can be accepted" do
    friend_request = FriendRequest.new(sender: sending_user, recipient: receiving_user)
    friend_request.accept
    expect(friend_request.accepted).to be true
  end
end
