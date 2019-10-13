class FavoritesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @favlist = Favlist.find(params[:favlist_id])
    @favlist.like(@micropost)
    flash[:success] = '素材をコラボリストに入れました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    @favlist = Favlist.find(params[:favlist_id])
    @favlist.unlike(@micropost)
    flash[:success] = '素材をコラボリストから取り出しました。'
    redirect_back(fallback_location: root_path)
  end

end
