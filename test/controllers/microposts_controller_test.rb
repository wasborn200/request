require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @micropost = microposts(:orange)
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { title: "song", content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for other users micropost" do
    log_in_as(@user)
    micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete micropost_path(micropost)
    end
    assert_redirected_to root_url
  end

  test "should get new" do
    log_in_as(@user)
    get new_micropost_path
    assert_response :success
  end

  test "should edit micropost" do
    title = "My song"
    content = "This micropost really ties the room together"
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    log_in_as(@user)
    patch micropost_path(@micropost), params: { micropost:
                       { title: title,
                         content: content,
                         picture: picture } }
    assert_redirected_to micropost_path(@micropost)
  end

  test "should not edit other users micropost" do
    title = "My song"
    content = "This micropost really ties the room together"
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    log_in_as(@other_user)
    patch micropost_path(@micropost), params: { micropost:
                       { title: title,
                         content: content,
                         picture: picture } }
    assert_redirected_to root_url
  end
end
