require 'test_helper'

class CommentInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @micropost = microposts(:orange)
    @my_comment = comments(:iolite)
    @other_user_comment = comments(:idocrase)
  end

  test "comment interface" do
    log_in_as(@user)
    get micropost_path(@micropost)
    # 無効な送信
    assert_no_difference 'Comment.count' do
      post micropost_comments_path(@micropost), params: { comment: {content: ""} }
    end
    follow_redirect!
    assert_template 'microposts/show'
    # 有効な送信
    assert_difference 'Comment.count' do
      post micropost_comments_path(@micropost), params: { comment: {content: "yeh!"} }
    end
    follow_redirect!
    assert_template 'microposts/show'
  end
end
