require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  def concerts
    remote = Songkickr::Remote.new ENV["SONGKICK_API_KEY"]
    @results = remote.events(location: "clientip").results
  end

  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end
end
