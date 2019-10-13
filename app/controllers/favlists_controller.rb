class FavlistsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :new]
  before_action :correct_user,   only: [:show, :edit, :destroy, :update]
  before_action :require_favlist, only: [:likes, :show, :edit, :update]

  def likes
    @favpost = @favlist.favposts.page(params[:page])
    counts(@favlist)
  end

  def create
    @favlist = current_user.favlists.build(favlist_params)
    if @favlist.save
      flash[:success] = "コラボリストを作成しました！"
      redirect_to favlist_path(@favlist)
    else
      render 'favlists/new'
    end
  end

  def destroy
    @favlist.destroy
    flash[:success] = "コラボリストを削除しました。"
    redirect_to root_url
  end

  def new
    @favlist = Favlist.new
  end

  def show
    @microposts = @favlist.favposts.map(&:id)
    @micropost = Micropost.new
  end

  def index
    @favlists = current_user.favlists.all
  end

  def edit
  end

  def update
    if @favlist.update_attributes(favlist_params)
      flash[:success] = "コラボリストを更新しました。"
      redirect_to favlist_path(@favlist)
    else
      render 'edit'
    end
  end

  private

    def favlist_params
      params.require(:favlist).permit(:title, :memo)
    end

    def correct_user
      @favlist = current_user.favlists.find_by(id: params[:id])
      redirect_to root_url if @favlist.nil?
    end

    def require_favlist
      @favlist = Favlist.find(params[:id])
    end

end
