require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get chatroom" do
    get static_pages_home_url
    assert_response :success
  end
end
