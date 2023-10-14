require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  it "is valid with valid attributes" do
    user1 = User.create
    user2 = User.create
    friend_request = FriendRequest.new(sender: user1, recipient: user2)
    expect(friend_request).to be_valid
  end

  it "is not valid without a sender" do
    user = User.create
    friend_request = FriendRequest.new(recipient: user)
    expect(friend_request).not_to be_valid
  end

  it "is not valid without a recipient" do
    user = User.create
    friend_request = FriendRequest.new(sender: user)
    expect(friend_request).not_to be_valid
  end
end
