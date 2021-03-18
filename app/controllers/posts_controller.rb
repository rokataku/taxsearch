class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :show, :good, :ungood]
  before_action :move_to_index, except: [:index, :show, :search]
  before_action :search_post, only: [:index, :genre_search]

  

  def index
    @posts = Post.includes(:user).order(id: "DESC")
    set_post_column
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
      render :new
    end
  end

  def edit
    load_post

    @post = PostsTag.new(post: @post)
  end

  def update
    load_post

    @post = PostsTag.new(post_params, post: @post)

    if @post.save
      redirect_to @post, notice: 'The post has been updated.'
    else
      render :edit
    end
  end

  def destroy
    post = PostsTag.find(params[:id])
    post.destroy
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(id: "DESC")
    @likes = @post.likes.includes(:user_id).order(id: "DESC")
  end

  def search
    @posts = Post.search(params[:keyword]).order(id: "DESC")
  end

  def incremental_search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  def genre_search
    @results = @p.result
    genre_id = params[:q][:genre_id_eq]
    @genre = Genre.find_by(id: genre_id)
  end

  # いいね
  def good
    current_user.liked_posts << @post
    redirect_to post_path
  end

  # いいね削除
  def ungood
    current_user.liked_posts.destroy(@post)
    redirect_to post_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :text, :genre_id, :image, :tag_names).merge(user_id: current_user.id)
  end

  def load_post
    @post = current_user.posts.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def search_post
    @p = Post.ransack(params[:q])
  end

  def set_post_column
    @post_title = Post.select("title").distinct  # 重複なくtitleカラムのデータを取り出す
  end

end