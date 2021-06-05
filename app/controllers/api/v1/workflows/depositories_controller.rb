module API
  module V1
    module Workflows
      class DepositoriesController < ApplicationController
        before_action :set_depository, only: [:show, :update, :destroy]
      
        # GET /depositories
        def index
          @depositories = Workflow::Depository.all
          @pagy, records = pagy(@depositories)
          records = records.includes(:company).each do |record|
            record[:company_name] = record.company.name
            record[:created_on] = record.created_on
          end
          render json: records
        end
      
        # GET /depositories/1
        def show
          render json: @depository
        end
      
        # POST /depositories
        def create
          @depository = Workflow::Depository.new(depository_params)
      
          if @depository.save
            render json: @depository, status: :created, location: @depository
          else
            render json: @depository.errors, status: :unprocessable_entity
          end
        end
      
        # PATCH/PUT /depositories/1
        def update
          if @depository.update(depository_params)
            render json: @depository
          else
            render json: @depository.errors, status: :unprocessable_entity
          end
        end
      
        # DELETE /depositories/1
        def destroy
          @depository.destroy
        end
      
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_depository
            @depository = Workflow::Depository.find(params[:id])
          end
      
          # Only allow a list of trusted parameters through.
          def depository_params
            params.require(:depository).permit(:name, :email, :phone, :callForwarding)
          end
      end      
    end
  end
end
