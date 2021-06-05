class API::V1::CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :update, :destroy, :setting, :plans, :current_plan]

  # GET /campaigns
  def index
    @campaigns = Campaign::Depository
    @pagy, records = pagy(@campaigns)
    
    records = records.includes(:company).each do |record|
      record[:company_name] = record.company.name
      record[:created_on] = record.created_on
    end
    render json: records
  end

  # GET /campaigns/1
  def show
    render json: @campaign
  end

  # POST /campaigns
  def create
    @campaign = Campaign::Depository.new(campaign_params)

    if @campaign.save
      render json: @campaign, status: :created, location: @campaign
    else
      render json: @campaign.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /campaigns/1
  def update
    if @campaign.update(campaign_params)
      render json: @campaign
    else
      render json: @campaign.errors, status: :unprocessable_entity
    end
  end

  # DELETE /campaigns/1
  def destroy
    @campaign.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def campaign_params
      params.require(:campaign).permit(:name, :email, :phone, :callForwarding)
    end
end
