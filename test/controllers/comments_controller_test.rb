require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @my_comment = comments(:iolite)
    @other_user_comment = comments(:idocrase)
  end

end
