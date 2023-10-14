require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  it "is valid with valid attributes" do
    user1 = User.create
    user2 = User.create
    friend_request = FriendRequest.new(sender: user1, recipient: user2)
    expect(friend_request).to be_valid
  end
end
