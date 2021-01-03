class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show]
  def index  
    @posts = Post.all.order(id: "DESC")
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  def edit
  end

  def show
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
