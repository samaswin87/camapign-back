require "test_helper"

class TwilioSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @twilio_setting = twilio_settings(:one)
  end

  test "should get index" do
    get twilio_settings_url, as: :json
    assert_response :success
  end

  test "should create twilio_setting" do
    assert_difference('TwilioSetting.count') do
      post twilio_settings_url, params: { twilio_setting: { sid: @twilio_setting.sid, token: @twilio_setting.token } }, as: :json
    end

    assert_response 201
  end

  test "should show twilio_setting" do
    get twilio_setting_url(@twilio_setting), as: :json
    assert_response :success
  end

  test "should update twilio_setting" do
    patch twilio_setting_url(@twilio_setting), params: { twilio_setting: { sid: @twilio_setting.sid, token: @twilio_setting.token } }, as: :json
    assert_response 200
  end

  test "should destroy twilio_setting" do
    assert_difference('TwilioSetting.count', -1) do
      delete twilio_setting_url(@twilio_setting), as: :json
    end

    assert_response 204
  end
end
