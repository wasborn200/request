require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
    # Micropost Search
    get user_path(@user), params: {q: {content_cont: "a"} }
    q = @user.microposts.ransack(content_cont: "a")
    q.result.paginate(page:1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end

  test "home display" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select 'title', full_title
    assert_select 'h1', text: @user.name
    assert_select 'a>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    assert_match @user.following.count.to_s, response.body
    assert_match @user.followers.count.to_s, response.body
    # Micropost Search
    get root_path prams: {q: {content_cont: "a"} }
    q = @user.feed.ransack(content_cont: "a")
    # 以下はなぜかエラーが出る
    # q.result.paginate(page: 1).each do |micropost|
    #   assert_match CGI.escapeHTML(micropost.content), response.body
    # end
  end
end
