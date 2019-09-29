require 'test_helper'

class AplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "Collab RE:Quest"
    assert_equal full_title("Help"), "Help | Collab RE:Quest"
  end
end
