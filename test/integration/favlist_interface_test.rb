require 'test_helper'

class FavlistCreateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "favlist interface" do
    log_in_as(@user)
    get new_favlist_path
    assert_select 'form[action="/favlists/new"]'
    # 無効な送信
    assert_no_difference 'Favlist.count' do
      post favlists_path, params: { favlist: { title: "", memo: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    title = "my favorite songs"
    memo = "I like this music"
    assert_difference 'Favlist.count' do
      post favlists_path, params: { favlist: { title: title, memo: memo } }
    end
    follow_redirect!
    assert_template 'favlists/show'
    assert_match memo, response.body
    assert_select 'a', text: 'delete'
    assert_select 'a', text: 'edit'
    # お気に入りリストを編集する
    get edit_favlist_path(favlists(:RnB))
    title2 = "Soul"
    memo2 = "recent favorite songs"
    patch favlist_path, params: { favlist:
                       { title: title2,
                         memo: memo2 } }
    follow_redirect!
    assert_template 'favlists/show'
    assert_select 'a', text: 'edit'
    assert_select 'a', text: 'delete'
    # お気に入りリストを削除する
    get favlist_path(favlists(:RnB))
    assert_difference 'Favlist.count', -1 do
      delete favlist_path(favlists(:RnB))
    end
  end
end
