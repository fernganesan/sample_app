require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup 
    @base_title = "Ruby on Rails Tutorial Sample App"
    @user = users(:micheal)
    @other_user = users(:archer)
  end
  
  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Sign up | #{@base_title}"
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    get :update, id: @user, user: { name: 'foo bar' , email: 'google@gmail.com' }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@user)
    get :edit, id: @other_user
    assert !!flash[:danger]
    assert_redirected_to root_url
  end
  
  test "should redirect update when logged in as wrong user" do 
    log_in_as(@user)
    patch :update, id: @other_user, user: { name: @other_user.name, email: @other_user.email }
    assert !!flash[:danger]
    assert_redirected_to root_url
  end
       
  test "should redirect index when logged in" do
    get :index
    assert_redirected_to login_url
  end
  
end
