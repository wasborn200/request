require 'test_helper'

class FavlistTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @favlist = @user.favlists.build(title: "my favorite", memo: "Lorem ipsum")
  end

  test "should be valid" do
    assert @favlist.valid?
  end

  test "user id should be present" do
    @favlist.user_id = nil
    assert_not @favlist.valid?
  end

  test "title should be present" do
    @favlist.title = "  "
    assert_not @favlist.valid?
  end

  test "title should be at most 30 characters" do
    @favlist.title = "a" * 31
    assert_not @favlist.valid?
  end

  test "content should be at most 140 characters" do
    @favlist.memo = "a" * 141
    assert_not @favlist.valid?
  end

end
