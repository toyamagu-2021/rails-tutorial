require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "valid signup new user" do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: { user: { name:  "test",
                                        email: "test@example.com",
                                        password:              "testtest",
                                        password_confirmation: "testtest" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
  test "invalid signup new user" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                        email: "user@invalid",
                                        password:              "foo",
                                        password_confirmation: "bar" } }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
  end
end
