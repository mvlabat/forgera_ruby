require 'test_helper'

class ModsControllerTest < ActionDispatch::IntegrationTest
  test "should get test" do
    get mods_test_url
    assert_response :success
  end

end
