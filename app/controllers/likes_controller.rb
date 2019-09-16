class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @like = current_user.likes.create(micropost_id: params[:micropost_id])
    redirect_to micropost_path(@micropost)
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    @like = Like.find_by(micropost_id: params[:micropost_id], user_id: current_user.id)
    @like.destroy
    redirect_to micropost_path(@micropost)
  end

end
