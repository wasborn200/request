class CommentsController < ApplicationController

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to micropost_path(@micropost)
    else
      render "microposts/show"
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :micropost_id)
    end
end
