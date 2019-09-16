require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @micropost = microposts(:ants)
    @other_user = users(:archer)
    @other_micropost = microposts(:orange)
  end

  test "should create like" do
    log_in_as(@user)
    get micropost_path(@micropost)
    assert_difference 'Like.count' do
      post micropost_likes_path(@micropost)
    end
    assert_redirected_to micropost_path(@micropost)
  end

  test "should destroy like" do
    log_in_as(@other_user)
    get micropost_path(@other_micropost)
    assert_difference 'Like.count', -1 do
      delete micropost_like_path(@other_micropost)
    end
    assert_redirected_to micropost_path(@other_micropost)
  end
end
