class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :new]
  before_action :correct_user,   only: [:destroy, :update, :edit]
  before_action :require_micropost, only: [:show, :edit, :update]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to micropost_path(@micropost)
    else
      render 'microposts/new'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to root_url
  end

  def new
    @micropost = Micropost.new
  end

  def show
    @comments = @micropost.comments.paginate(page: params[:page], per_page: 10)
    @comment = Comment.new
    @like = Like.new
    @favlists = current_user.favlists.all
  end

  def edit
  end

  def update
    if @micropost.update_attributes(micropost_params)
      flash[:success] = "Micropost updated"
      redirect_to micropost_path(@micropost)
    else
      render 'edit'
    end
  end

  def index
    if logged_in?
      @micropost = Micropost.where(collablist: nil)
      @all_ranks = Micropost.create_all_ranks
      if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
        @q = @micropost.ransack(microposts_search_params)
        @feed_items = @q.result.paginate(page: params[:page])
      else
        @q = @micropost.none.ransack
        @feed_items = @micropost.paginate(page: params[:page])
      end
      @url = microposts_path
    end
  end

  def collabposts
    if logged_in?
      @micropost = Micropost.where.not(collablist: nil)
      @all_ranks = Micropost.create_all_ranks
      if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
        @q = @micropost.ransack(microposts_search_params)
        @feed_items = @q.result.paginate(page: params[:page])
      else
        @q = @micropost.none.ransack
        @feed_items = @micropost.paginate(page: params[:page])
      end
      @url = collabposts_microposts_path
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:title, :content, :picture, :collablist)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    def require_micropost
      @micropost = Micropost.find(params[:id])
    end
end
