class PostsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def like
    @post = Post.all.find(params[:id])
      Like.create(user_id: current_user.id, post_id: @post.id)
    redirect_to post_path(@post)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "Post was successfully deleted"
      redirect_to "/posts"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "Post was updated successfully"
      redirect_to "/posts"
    else  
      render 'edit'
    end
  end

  def index
    @post = Post.order(:id)
    if params[:order] == 'title'
      @post = Post.all.order('title')
    elsif params[:order] == 'likes'
        @post = Post.all.order('likes')
    else
      @post = Post.all.order('description')
    end
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