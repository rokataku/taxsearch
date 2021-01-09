class CommentsController < ApplicationController
  def create
    comment = Comment.create!(comment_params)
    redirect_to "/posts/#{comment.post.id}"
  end


  def checked
    comment = Comment.find(comment_params[:id])
    if comment.checked
      comment.update(checked: false)
    else
      comment.update(checked: true)
    end

    item = Comment.find(comment_params[:id])
    render json: { comment: item}
  end


  private
  def comment_params
    params.require(:comment).permit(:id, :content).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
