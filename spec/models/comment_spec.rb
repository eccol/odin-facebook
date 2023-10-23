require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post_user) { User.create!(email: "post@post.post", password: "123456", profile_attributes: {name: "Poster"})}
  let(:comment_user) { User.create!(email: "comment@comment.comment", password: "123456", profile_attributes: {name: "Commenter"})}
  let(:post) { post_user.posts.new(content: "This is a post.")}

  it "is valid with content" do
    comment = Post.comments.new(user_id: comment_user.id, content: "Fantabuluous!")
    expect(comment).to be_valid
  end

  it "is not valid without content" do
    comment = Post.comments.new(user_id: comment_user.id)
    expect(comment).not_to be_valid
  end
end
