class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :new]
  before_action :correct_user,   only: [:destroy, :update, :edit]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to micropost_path(@micropost)
      # redirect_to root_url
    else
      render 'microposts/new'
      # @q = Micropost.none.ransack
      # @feed_items = current_user.feed.paginate(page: params[:page])
      # redirect_back(fallback_location: root_url)
      # render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to root_url
    # showページで削除をする場合、以下のコードが利用できない
    # redirect_back(fallback_location: root_url)
  end

  # create_new_pages
  def new
    @micropost = Micropost.new
  end

  def show
    @micropost = Micropost.find(params[:id])
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(micropost_params)
      flash[:success] = "Micropost updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def index
    if logged_in?
      @micropost = Micropost.all
      if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
        @q = Micropost.ransack(microposts_search_params)
        @feed_items = @q.result.paginate(page: params[:page])
      else
        @q = Micropost.none.ransack
        @feed_items = Micropost.paginate(page: params[:page])
      end
      @url = root_path
    end
  end


  private

    def micropost_params
      params.require(:micropost).permit(:title, :content, :picture)
      # ここに音楽ファイル追加したい
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
