module API
  module V1
    module Platforms
      class OperatorsController < ApplicationController
        before_action :set_operator, only: [:show, :update, :destroy]
      
        # GET /operators
        def index
          @operators = Platform::Operator
          @pagy, records = pagy(@operators)
    
          render json: records
        end
      
        # GET /operators/1
        def show
          render json: @operator
        end
      
        # POST /operators
        def create
          @operator = Platform::Operator.new(operator_params)
      
          if @operator.save
            render json: @operator, status: :created, location: @operator
          else
            render json: @operator.errors, status: :unprocessable_entity
          end
        end
      
        # PATCH/PUT /operators/1
        def update
          if @operator.update(operator_params)
            render json: @operator
          else
            render json: @operator.errors, status: :unprocessable_entity
          end
        end
      
        # DELETE /operators/1
        def destroy
          @operator.destroy
        end
      
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_operator
            @operator = Platform::Operator.find(params[:id])
          end
      
          # Only allow a list of trusted parameters through.
          def operator_params
            params.require(:operator).permit(:name, :email, :phone, :callForwarding)
          end
      end      
    end
  end
end