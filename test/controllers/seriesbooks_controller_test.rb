require "test_helper"

class SeriesbooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get seriesbooks_index_url
    assert_response :success
  end
end
