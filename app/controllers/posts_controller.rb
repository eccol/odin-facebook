class PostsController < ApplicationController
  def index
    @posts = Post.where(user_id: current_user.friends.map(&:id).append(current_user)).order(created_at: :desc)
    @friends = current_user.friends
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.turbo_stream
      else
        format.html {render :new, status: :unprocessable_entity}
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end
end
