class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def index
    @post = Post.all
  end

  def new
   @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to "/posts"
      flash[:notice] = "Post was successfully added"
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :user_id)
  end
end