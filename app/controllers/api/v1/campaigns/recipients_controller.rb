module API
    module V1
        module Campaigns
            class RecipientsController < ApplicationController
                before_action :set_depository, only: [:index, :update]
                before_action :set_recipient, only: [:update]

                # GET /recipients
                def index
                    filterrific = {}
                    filterrific['search_query'] = params[:searchparam] || ''
                    filters = params[:filters]
                    recipients = filterrific['search_query'].present? ? @depository.recipients : @depository.recipients.order("updated_at DESC")
                    if filters.present?
                        filterrific = JSON.parse(filters)
                    end
                    @filterrific = initialize_filterrific(
                        recipients,
                        filterrific
                    ) or return
                    @pagy, records = pagy(@filterrific.find, items: params[:limit].to_i | 20)
                    
                    recipients = [] 
                    records.includes(:platform_recipient).each_with_index do |record, index|
                        record_attributes = record.attributes
                        record_attributes[:platform_recipient] = record.platform_recipient
                        record_attributes[:row_id] = index + 1
                        record_attributes[:created_on] = record.created_on
                        recipients << record_attributes
                    end

                    render json: recipients
                end

                # PATCH/PUT /recipients/1
                def update
                    if @recipient.update(recipient_params)
                        render json: @recipient
                    else
                        render json: @recipient.errors, status: :unprocessable_entity
                    end
                end

                # POST /recipients
                def create
                    new_params = {
                        recipient_id: recipient_params[:recipient_id],
                        depository_id: params[:depository_id]
                    }
                    @recipient = Campaign::Recipient.new(new_params)
                
                    if @recipient.save
                    render json: @recipient, status: :created
                    else
                    render json: @recipient.errors, status: :unprocessable_entity
                    end
                end

                private

                # Use callbacks to share common setup or constraints between actions.
                def set_depository
                    @depository = Campaign::Depository.find(params[:depository_id])
                end

                def set_recipient
                    @recipient = Campaign::Recipient.find(params[:id])
                end
            
                # Only allow a list of trusted parameters through.
                def recipient_params
                    params.require(:recipient).permit(
                    :recipient_id,
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
