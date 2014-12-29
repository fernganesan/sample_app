require 'test_helper'

class UsersIndexTestTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @admin = users(:micheal)
    @non_admin = users(:archer)
  end
  
  test "Index including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1, per_page: 10).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
	assert_select 'a[href=?]', user_path(user), text: 'delete',
	                                            method: :delete
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end
  
end
