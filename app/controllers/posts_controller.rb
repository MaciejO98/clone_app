class PostsController < ApplicationController
  before_action :set_post, except: [:index, :new, :create]

  def like
    Like.create(user: current_user, post: @post)
    redirect_to post_path(@post)
  end

  def show
  end

  def edit
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Post was successfully deleted"
      redirect_to "/posts"
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post was updated successfully"
      redirect_to "/posts"
    else  
      render 'edit'
    end
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

  def set_post
    @post = Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit(:title, :description, :user_id)
  end
end