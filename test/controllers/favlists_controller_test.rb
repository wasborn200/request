require 'test_helper'

class FavlistsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @favlist = favlists(:RnB)
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Favlist.count' do
      post favlists_path, params: { favlist: { title: "my favorite songs", memo: "I like this music" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Favlist.count' do
      delete favlist_path(@favlist)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for other users favlist" do
    log_in_as(@user)
    favlist = favlists(:JPOP)
    assert_no_difference 'Favlist.count' do
      delete favlist_path(favlist)
    end
    assert_redirected_to root_url
  end

  test "should get new" do
    log_in_as(@user)
    get new_favlist_path
    assert_response :success
  end

  test "should edit favlist" do
    title = "POP"
    memo = "My favorite music"
    log_in_as(@user)
    patch favlist_path(@favlist), params: { favlist:
                       { title: title,
                         memo: memo } }
    assert_redirected_to favlist_path(@favlist)
  end

  test "should not edit other users favlist" do
    title = "POP"
    memo = "My favorite music"
    log_in_as(@other_user)
    patch favlist_path(@favlist), params: { favlist:
                       { title: title,
                         memo: memo } }
    assert_redirected_to root_url
  end

  test "should redirect show when logged in as wrong user" do
    log_in_as(@other_user)
    get favlist_path(favlists(:JPOP))
    assert flash.empty?
    assert_redirected_to root_url
  end
end
