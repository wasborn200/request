class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "コメントを投稿しました。"
      redirect_to micropost_path(@micropost)
    else
      flash[:danger] = "コメントを投稿できませんでした。"
      redirect_to micropost_path(@micropost)
    end
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :micropost_id)
    end
end
