class FavoritesController < ApplicationController

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @favlist = Favlist.find(params[:favlist_id])
    @favlist.like(@micropost)
    flash[:success] = 'お気に入り登録をしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    @favlist = Favlist.find(params[:favlist_id])
    @favlist.unlike(@micropost)
    flash[:success] = 'お気に入り登録を解除しました。'
    redirect_back(fallback_location: root_path)
  end

end
