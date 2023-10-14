require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:poster) { User.create!(email: "c@c.c", password: "123456") }

  it "is valid with valid attributes" do
    post = poster.posts.build(content: "This post should be fine.")
    post.save
    expect(post).to be_valid
  end

  it "cannot be blank" do
    post = poster.posts.build
    post.save
    expect(post).not_to be_valid
  end
end
