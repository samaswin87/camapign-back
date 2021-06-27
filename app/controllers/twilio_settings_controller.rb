class TwilioSettingsController < ApplicationController
  before_action :set_twilio_setting, only: [:show, :update, :destroy]

  # GET /twilio_settings
  def index
    @twilio_settings = TwilioSetting.all

    render json: @twilio_settings
  end

  # GET /twilio_settings/1
  def show
    render json: @twilio_setting
  end

  # POST /twilio_settings
  def create
    @twilio_setting = TwilioSetting.new(twilio_setting_params)

    if @twilio_setting.save
      render json: @twilio_setting, status: :created, location: @twilio_setting
    else
      render json: @twilio_setting.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /twilio_settings/1
  def update
    if @twilio_setting.update(twilio_setting_params)
      render json: @twilio_setting
    else
      render json: @twilio_setting.errors, status: :unprocessable_entity
    end
  end

  # DELETE /twilio_settings/1
  def destroy
    @twilio_setting.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twilio_setting
      @twilio_setting = TwilioSetting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def twilio_setting_params
      params.require(:twilio_setting).permit(:sid, :token)
    end
end
