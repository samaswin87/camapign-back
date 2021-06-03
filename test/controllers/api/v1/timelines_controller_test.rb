require "test_helper"

class API::V1::TimelinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_timelines_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_timelines_show_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_timelines_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_timelines_destroy_url
    assert_response :success
  end
end
