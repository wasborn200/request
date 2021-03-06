class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers, :message]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :require_user,   only: [:show, :edit, :update, :following, :followers, :message]

  def index
    if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
      @q = User.ransack(search_params, activated_true: true)
      @title = "検索結果"
    else
      @q = User.ransack(activated_true: true)
      @title = "ユーザー一覧"
    end
    @users = @q.result.paginate(page: params[:page])
  end

  def show
    redirect_to root_url and return unless @user.activated?
    if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
      @q = @user.microposts.ransack(microposts_search_params)
      @microposts = @q.result.paginate(page: params[:page])
    else
      @q = Micropost.none.ransack
      @microposts = @user.microposts.paginate(page: params[:page])
    end
    @url = user_path(@user)
    # メッセージ関係
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def message
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
  end

  def message_room_id(first_user, second_user)
    first_id = first_user.id.to_i
    second_id = second_user.id.to_i
    if first_id < second_id
      "#{first_user.id}-#{second_user.id}"
    else
      "#{second_user.id}-#{first_user.id}"
    end
  end


    private

    def search_params
      params.require(:q).permit(:name_cont)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                      :password_confirmation,
                                      :follow_notification,
                                      :unique_name)
    end

    # beforeアクション

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def require_user
      @user = User.find(params[:id])
    end

end
