require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "micropost interface" do
    log_in_as(@user)
    get new_micropost_path
    assert_select 'input[type=file]'
    # 無効な送信
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { title: "", content: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    title = "My song"
    content = "This micropost really ties the room together"
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Micropost.count' do
      post microposts_path, params: { micropost:
                         { title: title,
                           content: content,
                           picture: picture } }
    end
    follow_redirect!
    assert_template 'microposts/show'
    assert_match content, response.body
    assert_select 'a', text: '削除'
    assert_select 'a', text: '編集'
    micropost = Micropost.find_by(microposts)
    # トップページに戻ると、今さっき投稿したマイクロポストが最初に来ている
    get root_path
    first_micropost = @user.microposts.paginate(page: 1).first
    # 投稿を編集する
    get edit_micropost_path(micropost)
    title2 = "Guiter"
    content2 = "I practice guiter everyday"
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    patch micropost_path, params: { micropost:
                       { title: title2,
                         content: content2,
                         picture: picture } }
    follow_redirect!
    assert_template 'microposts/show'
    # 投稿を削除する
    get root_path
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(micropost)
    end
    # 違うユーザーのプロフィールにアクセス（削除リンクがないことを確認）
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end

  # マイクロポストの数を表示するページをマイページからマイクロポストshow、ユーザーshowに移す予定
  # test "micropost sidebar count" do
  #   log_in_as(@user)
  #   get root_path
  #   assert_match "#{@user.microposts.count} microposts", response.body
  #   # まだマイクロポストを投稿していないユーザー
  #   other_user = users(:malory)
  #   log_in_as(other_user)
  #   get root_path
  #   assert_match "0 microposts", response.body
  #   other_user.microposts.create!(title: "this song", content: "A micropost")
  #   get root_path
  #   assert_match "1 micropost", response.body
  # end

end
