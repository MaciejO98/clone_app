class PostsController < ApplicationController
  before_action :set_post, except: [:index, :new, :create, :search]

  def unlike
    if !(already_liked?)
      flash[:notice] = Cannot unlike
    else
      @like.destroy
    end
    redirect_to post_path(@post)
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field") and return
    else
      @parameter = params[:search].downcase
      @results = Post.all.where("lower(title) LIKE :search", search: @parameter)
    end
  end

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
    @post = Post.order(:id)
    if params[:order] == 'title'
      @post = Post.all.order('title')
    elsif params[:order] == 'likes_count'
        @post = Post.all.order('likes_count DESC')
    else
      @post = Post.all
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


  def set_post
    @post = Post.find(params[:id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, post_id:
    params[:post_id]).exists?
  end
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :user_id)
  end

end