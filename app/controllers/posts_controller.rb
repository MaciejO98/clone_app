class PostsController < ApplicationController


  def index

  end

  def new
   @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to "/posts/new"
      flash[:notice] = "Post was successfully added"
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end
end