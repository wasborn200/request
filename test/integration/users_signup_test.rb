require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                        email: "user@invalid",
                                        password: "foo",
                                        password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'form[action="/signup"]'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: { user: {name: "Example User",
                                       email: "user@example.com",
                                       password: "password",
                                       passowrd_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    assert_not flash.nil?
  end



end
