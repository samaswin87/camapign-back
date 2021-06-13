module API
  module V1
    module Campaigns
      class DepositoriesController < ApplicationController
        before_action :set_depository, only: [:show, :update, :destroy]
      
        # GET /depositories
        def index
          filterrific = {}
          filterrific['search_query'] = params[:searchparam] || ''
          filters = params[:filters]
          if filters.present?
            filterrific = JSON.parse(filters)
          end
          @filterrific = initialize_filterrific(
            Campaign::Depository,
            filterrific
          ) or return
          @pagy, records = pagy(@filterrific.find, items: params[:limit].to_i | 20)
          
          depositories = [] 
          records.includes(:company, :operator).each_with_index do |record, index|
            record_attributes = record.attributes
            record_attributes[:company_name] = record.company.name
            record_attributes[:operator] = record.operator.phone
            record_attributes[:row_id] = index + 1
            record_attributes[:created_on] = record.created_on
            depositories << record_attributes
          end

          render json: depositories
        end
      
        # GET /depositories/1
        def show
          render json: @depository
        end
      
        # POST /depositories
        def create
          if valid_name?
            render json: 'Name already exists', status: :conflict
            return
          end
          
          @depository = Campaign::Depository.new(depository_params)
          if @depository.save
            render json: @depository, status: :created
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
          if @depository.update({status: :inactive, archived_at: Time.now})
            render json: @depository
          else
            render json: @depository.errors, status: :unprocessable_entity
          end
        end
      
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_depository
            @depository = Campaign::Depository.find(params[:id])
          end
      
          # Only allow a list of trusted parameters through.
          def depository_params
            params.require(:depository).permit(
              :status, 
              :name,
              :scheduled_at, 
              :archived_at,
              :message, 
              :group, 
              :recurring_at, 
              :company_id, 
              :operator_id,
              recurring_days: [])
          end

          def valid_name?
            Campaign::Depository.where(name: depository_params[:name]).size > 0
          end
      end      
    end
  end
end
