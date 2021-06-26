module API
    module V1
        module Campaigns
            class CommunicationsController < ApplicationController
                before_action :set_depository, only: [:index, :create]
                before_action :set_recipient, only: [:index, :create]

                # GET /communications
                def index
                    render json: @recipient.communications.where(delivery: [:draft, :inbound, :outbound]).order("created_at DESC")
                end

                # POST /communications
                def create
                    @recipient = @recipient.communications.new(message: communication_params[:message])
                
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
                    unless @depository
                        render :json => 'Record not found', :status => :unprocessable_entity
                    end
                end

                def set_recipient
                    @recipient = Campaign::Recipient.find(params[:recipient_id])
                    unless @recipient
                        render :json => 'Record not found', :status => :unprocessable_entity
                    end
                end
            
                # Only allow a list of trusted parameters through.
                def communication_params
                    params.require(:communication).permit(
                    :recipient_id,
                    :delivery,
                    :message)
                end
            end            
        end
    end
end
