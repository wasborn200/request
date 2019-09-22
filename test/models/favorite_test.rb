require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  # test "the truth" do
  def setup
    @favorite = Favorite.new(favlist_id: favlists(:RnB).id,
                             micropost_id: microposts(:orange).id)
  end

  test "should be valid" do
    assert @favorite.valid?
  end

  test "should require a favlist_id" do
    @favorite.favlist_id = nil
    assert_not @favorite.valid?
  end

  test "should require a micropost_id" do
    @favorite.micropost_id = nil
    assert_not @favorite.valid?
  end
end
