module API
  module V1
    module Platforms
      class RecipientsController < ApplicationController
        before_action :set_recipient, only: [:show, :update, :destroy]
      
        # GET /recipients
        def index
          filterrific = {}
          filterrific['search_query'] = params[:searchparam] || ''
          filters = params[:filters]
          if filters.present?
            filterrific = JSON.parse(filters)
          end
          @filterrific = initialize_filterrific(
            Platform::Recipient,
            filterrific
          ) or return
          @pagy, records = pagy(@filterrific.find, items: params[:limit].to_i | 20)
          
          recipients = [] 
          records.includes(:company).each_with_index do |record, index|
            record_attributes = record.attributes
            record_attributes[:company_name] = record.company.name
            record_attributes[:row_id] = index + 1
            recipients << record_attributes
          end
          render json: recipients
        end
      
        # GET /recipients/1
        def show
          attributes = @recipient.attributes
          attributes[:company_name] = @recipient.company.name
          render json: attributes
        end
      
        # POST /recipients
        def create
          @recipient = Platform::Recipient.new(recipient_params)
      
          if @recipient.save
            render json: @recipient, status: :created
          else
            render json: @recipient.errors, status: :unprocessable_entity
          end
        end
      
        # PATCH/PUT /recipients/1
        def update
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

        # PATCH/PUT /recipients/update_tags
        def update_tags
          tag_params = params[:tags]
          recipients = Platform::Recipient.where(id: params[:contacts])
          recipients.each do |recipient|
            new_tags = (recipient.tags - tag_params[:removed]) + tag_params[:added]
            recipient.update(tags: new_tags)
          end
          render json: {message: 'Tags updated for the selected contacts'}
        end

        # GET /recipients/tags
        def tags
          tags = Tag.pluck(:name).uniq
          render json: tags
        end

        # GET /recipients/keywords
        def keywords
          keywords = Platform::Recipient.pluck(:keywords).flatten.uniq
          render json: keywords
        end
      
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_recipient
            @recipient = Platform::Recipient.find(params[:id])
          end
      
          # Only allow a list of trusted parameters through.
          def recipient_params
            params.require(:recipient).permit(
              :first_name,
              :last_name,
              :middle_name,
              :no_of_campaigns,
              :keywords,
              :notes,
              :gender,
              :email,
              :phone,
              :company_id,
              :status,
              :country_code,
              :country_extension,
              :searchparam,
              :filters,
              tags: [],
              contacts: []
              )
          end
      end      
    end
  end
end
