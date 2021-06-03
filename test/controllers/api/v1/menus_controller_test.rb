require "test_helper"

class API::V1::MenusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_menus_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_menus_show_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_menus_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_menus_destroy_url
    assert_response :success
  end
end
