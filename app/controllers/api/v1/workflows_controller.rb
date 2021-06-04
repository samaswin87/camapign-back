class API::V1::WorkflowsController < ApplicationController
  before_action :set_workflow, only: [:show, :update, :destroy, :setting, :plans, :current_plan]

  # GET /workflows
  def index
    @workflows = Workflow::Depository.all
    @pagy, records = pagy(@workflows)
    render json: records
  end

  # GET /workflows/1
  def show
    render json: @workflow
  end

  # POST /workflows
  def create
    @workflow = Workflow::Depository.new(workflow_params)

    if @workflow.save
      render json: @workflow, status: :created, location: @workflow
    else
      render json: @workflow.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /workflows/1
  def update
    if @workflow.update(workflow_params)
      render json: @workflow
    else
      render json: @workflow.errors, status: :unprocessable_entity
    end
  end

  # DELETE /workflows/1
  def destroy
    @workflow.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workflow
      @workflow = Workflow.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def workflow_params
      params.require(:workflow).permit(:name, :email, :phone, :callForwarding)
    end
end
