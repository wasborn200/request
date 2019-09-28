class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @all_ranks = Micropost.create_all_ranks
      @my_ranks  = @all_ranks.select{ |micropost| micropost.user_id == current_user.id }
      @comments = Comment.where(micropost_id: micropost_ids).last(3).reverse
      if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
        @q = current_user.feed.ransack(microposts_search_params)
        @feed_items = @q.result.paginate(page: params[:page], per_page: 10)
      else
        @q = Micropost.none.ransack
        @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
      end
      @url = root_path
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def micropost_ids
    micropost_ids = Micropost.where(user_id: current_user.id)
  end

end
