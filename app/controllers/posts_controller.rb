class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).where(user_id: current_user.friends.map(&:id).append(current_user)).order(created_at: :desc)
    @friends = current_user.friends
    @notifications = current_user.notifications
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

  def destroy
    post = Post.find(params[:id])

    if post.user == current_user
      Post.find(params[:id]).destroy
      redirect_to posts_path, notice: "Post deleted."
    else
      redirect_to posts_path, status: :unprocessable_entity
    end
  end

  def like
    @post = Post.find(params[:id])
    @user = current_user
    @like = Like.find_by(post: @post, user: @user)
    if @like
      @like.destroy
    else
      @post.likes.create(user: @user)
    end
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end
end
