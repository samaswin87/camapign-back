class API::V1::CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :update, :destroy, :setting, :plans, :current_plan]

  # GET /companies
  def index
    @companies = Company.all
    @pagy, records = pagy(@companies)
    render json: records
  end

  # GET /names
  def names
    @companies = Company.select(:id, :name)
    render json: @companies
  end
  
  # GET /companies/1
  def show
    render json: @company
  end

  # GET /companies/1/setting
  def setting
    render json: @company.setting
  end

  # GET /companies/1/plans
  def plans
    @pagy, records = pagy(@company.plans)
    render json: records
  end

  # GET /companies/1/current_plan
  def current_plan
    render json: @company.current_plan
  end

  # POST /companies
  def create
    @company = Company.new(company_params)

    if @company.save
      render json: @company, status: :created, location: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      render json: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  # DELETE /companies/1
  def destroy
    @company.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name, :email, :phone, :callForwarding)
    end
end
