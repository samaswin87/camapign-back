module API
    module V1
        module Campaigns
            class RecipientsController < ApplicationController
                before_action :set_depository, only: [:index]

                # GET /recipients
                def index
                    filterrific = {}
                    filterrific['search_query'] = params[:searchparam] || ''
                    filters = params[:filters]
                    if filters.present?
                        filterrific = JSON.parse(filters)
                    end
                    @filterrific = initialize_filterrific(
                        @depository.recipients,
                        filterrific
                    ) or return
                    @pagy, records = pagy(@filterrific.find, items: params[:limit].to_i | 20)
                    
                    recipients = [] 
                    records.includes(:platform_recipient).each_with_index do |record, index|
                        record_attributes = record.attributes
                        record_attributes[:recipient] = record.platform_recipient.phone
                        record_attributes[:tags] = record.platform_recipient.tags
                        record_attributes[:row_id] = index + 1
                        record_attributes[:created_on] = record.created_on
                        recipients << record_attributes
                    end

                    render json: recipients
                end

                private

                # Use callbacks to share common setup or constraints between actions.
                def set_depository
                    @depository = Campaign::Depository.find(params[:depository_id])
                end
            
                # Only allow a list of trusted parameters through.
                def recipient_params
                    params.require(:recipient).permit(
                    :status, 
                    :name,
                    :state,
                    :scheduled_at, 
                    :archived_at,
                    :message, 
                    :group, 
                    :recurring_at, 
                    :company_id, 
                    :operator_id,
                    recurring_days: [])
                end
            end            
        end
    end
end
