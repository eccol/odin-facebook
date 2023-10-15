require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  let(:sending_user) { User.create!(email: "a@a.a", password: "abcabc") }
  let(:receiving_user) { User.create!(email: "b@b.b", password: "cbacba") }

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

  it "is not valid if the sender already sent a request to the recipient" do
    friend_request = FriendRequest.new(sender: sending_user, recipient: receiving_user)
    friend_request.save
    friend_request2 = FriendRequest.new(sender: sending_user, recipient: receiving_user)
    expect(friend_request2).not_to be_valid
  end

  it "is not valid if the recipient already sent a request to the sender" do
    friend_request = FriendRequest.new(sender: sending_user, recipient: receiving_user)
    friend_request.save
    friend_request2 = FriendRequest.new(sender: receiving_user, recipient: sending_user)
    expect(friend_request2).not_to be_valid
  end
end
