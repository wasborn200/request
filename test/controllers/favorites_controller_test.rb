require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @micropost = microposts(:cat_video)
    @user = users(:archer)
    @favlist = favlists(:JPOP)
  end

  test "should create favorite when logged-in" do
    log_in_as(@user)
    get micropost_path(@micropost)
    assert_difference 'Favorite.count' do
      post favorites_path, params: { micropost_id: @micropost.id, favlist_id: @favlist.id }
    end
  end

  test "create should require logged-in user" do
    assert_no_difference 'Favorite.count' do
      post favorites_path, params: { micropost_id: @micropost.id, favlist_id: @favlist.id }
    end
    assert_redirected_to login_url
  end
  #
  test "destroy should require logged-in user" do
    assert_no_difference 'Favorite.count' do
      delete favorite_path(favorites(:like1))
    end
    assert_redirected_to login_url
  end

end
