require "test_helper"

class Api::V1::SismosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_sismos_index_url
    assert_response :success
  end

  test "should get create_comment" do
    get api_v1_sismos_create_comment_url
    assert_response :success
  end
end
