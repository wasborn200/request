require 'test_helper'

class LikesRankingTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @micropost = microposts(:ants) # antsは２年前の投稿
    log_in_as(@user)
  end

  test "should reflect for micropost ranking when user like and unlike micropost " do
    # いいねが付いていない投稿はランキングに表示されない
    get root_path
    assert_no_match @micropost.title, response.body
    # いいねを付けるとランキングに反映される
    get micropost_path(@micropost)
    assert_difference 'Like.count' do
      post micropost_likes_path(@micropost)
    end
    assert_redirected_to micropost_path(@micropost)
    get root_path
    assert_match @micropost.title, response.body
    # いいねを消すと投稿がランキングから消える
    get micropost_path(@micropost)
    assert_difference 'Like.count', -1 do
      delete micropost_like_path(@micropost)
    end
    get root_path
    assert_no_match @micropost.title, response.body
  end
end
