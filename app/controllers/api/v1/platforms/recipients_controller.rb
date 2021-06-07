module API
  module V1
    module Platforms
      class RecipientsController < ApplicationController
        before_action :set_recipient, only: [:show, :update, :destroy]
      
        # GET /recipients
        def index
          @recipients = Platform::Recipient.order('id ASC')
          @pagy, records = pagy(@recipients, items: params[:limit].to_i | 20)
          
          records = records.includes(:company).each_with_index do |record, index|
            record[:company_name] = record.company.name
            record[:row_id] = index + 1
          end
          render json: records
        end
      
        # GET /recipients/1
        def show
          render json: @recipient
        end
      
        # POST /recipients
        def create
          @recipient = Platform::Recipient.new(recipient_params)
      
          if @recipient.save
            render json: @recipient, status: :created, location: @recipient
          else
            render json: @recipient.errors, status: :unprocessable_entity
          end
        end
      
        # PATCH/PUT /recipients/1
        def update
          puts recipient_params
          if @recipient.update(recipient_params)
            render json: @recipient
          else
            render json: @recipient.errors, status: :unprocessable_entity
          end
        end
      
        # DELETE /recipients/1
        def destroy
          @recipient.destroy
        end

        # PATCH/PUT /recipients/statuses
        def statuses
          recipients = Platform::Recipient.where(id: params[:contacts])
          recipients.update_all(status: params[:status])
          render json: {message: 'Status updated for the selected contacts'}
        end
      
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_recipient
            @recipient = Platform::Recipient.find(params[:id])
          end
      
          # Only allow a list of trusted parameters through.
          def recipient_params
            params.require(:recipient).permit(:name, :email, :phone, :callForwarding, :status, :contacts)
          end
      end      
    end
  end
end
