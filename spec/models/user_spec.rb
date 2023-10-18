require 'rails_helper'

RSpec.describe User, type: :model do
  let(:sending_user) { User.create!(email: "c@c.c", password: "abcabc") }
  let(:receiving_user) { User.create!(email: "d@d.d", password: "cbacba") }
  let(:request) { FriendRequest.create(sender: sending_user, recipient: receiving_user) }

  context "#friends" do
    it "does not return unaccepted requests" do
    expect(sending_user.friends).not_to include(receiving_user)
    end

    it "returns accepted friend requests" do
      request.accept
      expect(sending_user.friends).to include(receiving_user)
    end
  end

  it 'accepts attributes for profile' do
    User.create!(email: 'user@internet.gov', password: '123456', profile_attributes: {name: "Gregory"})
    expect(User.last.profile.name).to eq "Gregory"
  end
end
