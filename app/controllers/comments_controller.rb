class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.parent_comment = @post.comments.find(params[:parent_comment_id]) if params[:parent_comment_id].present?
    @comment.user = current_user

    authorize @comment

    if @comment.save
      redirect_to post_path(@post), notice: "Comment was successfully added."
    else
      redirect_to post_path(@post), alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    redirect_to post_path(@comment.post), notice: "Comment was deleted."
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
