require "test_helper"

class API::V1::OperatorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_operators_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_operators_show_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_operators_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_operators_destroy_url
    assert_response :success
  end
end
