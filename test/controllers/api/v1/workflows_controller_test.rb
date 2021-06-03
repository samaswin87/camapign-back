require "test_helper"

class API::V1::WorkflowsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_workflows_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_workflows_show_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_workflows_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_workflows_destroy_url
    assert_response :success
  end
end
