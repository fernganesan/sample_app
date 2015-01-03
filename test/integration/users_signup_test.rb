require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "invalid signup information" do
    get signup_path
     assert_no_difference 'User.count' do
       post users_path, user: { name: "ganesn", email: "foo@invalid",
                                password: "foo", password_confirmation: "bar" }
     end
     assert_template 'users/new'
     assert_select 'div.field_with_errors', 6
     assert_select 'div#error_explanation' 
     assert_select 'div.alert'
     #assert @newUser.errors.any?
  end
  
  test "valid signup inforamtion" do
    get signup_path
     assert_difference 'User.count', 1 do
       post users_path, user: { name: "ganesan.arunachalam", email: "foo@bar.com",
                                password: "foobar", password_confirmation: "foobar" }
     end
     #assert_template 'users/show'
     assert_equal flash.count, 1
     assert !!flash[:info]
     #assert is_logged_in?
     assert_equal 1, ActionMailer::Base.deliveries.size
     user = assigns(:newUser)
     assert_not user.activated?
     # Try to log in before activation.
     log_in_as(user)
     assert_not is_logged_in?
     # Invalid activation token
     get edit_account_activation_path("Invalid token", email: user.email)
     assert_not is_logged_in?
     # Valid token, wrong email.
     get edit_account_activation_path(user.activation_token, email: "wrong")
     assert_not is_logged_in?
     # valid activation token
     get edit_account_activation_path(user.activation_token, email: user.email)
     assert user.reload.activated?
     follow_redirect!
     assert_template 'users/show'
     assert is_logged_in?
  end
end
