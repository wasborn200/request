require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  def setup
    @like = likes(:anemone)
  end

  test "should be valid" do
    assert @like.valid?
  end

end
