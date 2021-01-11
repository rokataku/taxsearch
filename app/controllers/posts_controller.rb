class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @posts = Post.all.order(id: "DESC")
  end

  def new
    @post = PostsTag.new
  end

  def create
    @post = PostsTag.new(post_params)
    if @post.valid?
      @post.save
      return redirect_to root_path
    else
      render "new"
    end
  end

  def destroy
    post = PostsTag.find(params[:id])
    post.destroy
  end

  def edit
  end

  def update
    post = PostsTag.find(params[:id])
    post.update(post_params)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(id: "DESC")
  end

  def search
    @posts = Post.search(params[:keyword]).order(id: "DESC")
  end

  def incremental_search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  private

  def post_params
    params.require(:posts_tag).permit(:title, :url, :text, :image, :name).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end