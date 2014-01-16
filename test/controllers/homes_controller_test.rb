require 'test_helper'

class HomesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

end
