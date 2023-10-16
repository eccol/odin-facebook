class PostsController < ApplicationController
  def index
    @posts = Post.all
    @friends = current_user.friends
  end
end
