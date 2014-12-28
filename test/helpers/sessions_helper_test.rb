require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  
  def setup
    @user = users(:micheal)
    remember(@user)
  end
  
  test "current_user should return right user when session is null" do
    # assert current_user?(@user), "Is there any issue"
    # assert logged_in?
  end
  
  test "current_user should return nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end