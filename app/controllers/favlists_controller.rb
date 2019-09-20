class FavlistsController < ApplicationController

  def create
    @favlist = current_user.favlists.build(favlist_params)
    if @favlist.save
      flash[:success] = "favlist created!"
      redirect_to favlist_path(@favlist)
    else
      render 'favlists/new'
    end
  end

  def destroy
    @favlist.destroy
    flash[:success] = "favlist deleted"
    redirect_to root_url
  end

  def new
    @favlist = Favlist.new
  end

  def show
    @favlist = Favlist.find(params[:id])
  end

  def index
    @favlists = current_user.favlists.all
  end

  private

    def favlist_params
      params.require(:favlist).permit(:title, :memo)
    end

    def correct_user
      @favlist = current_user.favlists.find_by(id: params[:id])
      redirect_to root_url if @favlist.nil?
    end


end
