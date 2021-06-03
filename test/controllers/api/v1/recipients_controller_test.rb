require "test_helper"

class API::V1::RecipientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_recipients_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_recipients_show_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_recipients_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_recipients_destroy_url
    assert_response :success
  end
end
