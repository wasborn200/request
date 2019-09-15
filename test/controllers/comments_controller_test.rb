require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @micropost = microposts(:orange)
  end

  test "should create comment" do
    log_in_as(@user)
    get micropost_path(@micropost)
    assert_difference 'Comment.count' do
      post micropost_comments_path(@micropost), params: { comment: {content: "yeh!"} }
    end
    assert_redirected_to micropost_path(@micropost)
  end

  test "should redirect when not logged in" do
    assert_no_difference 'Comment.count' do
      post micropost_comments_path(@micropost), params: { comment: {content: "yeh!"} }
    end
    assert_redirected_to login_url
  end

end
