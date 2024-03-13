module Api
  module V1
    class FundsController < ApplicationController

      def index
        fund = filter_list(Fund.all)
        render json: fund, status: :ok
      end
      def create
        fund = Fund.new(fund_params)
        if fund.save
          render json: { status: 'SUCCESS', data: fund }, status: :created
          UpdateFundPercentageRaised.call(fund.employee)
        else
          render json: { status: 'ERROR', data: fund.errors }, status: :unprocessable_entity
        end
      end

      private

      def filter_list(funds)
        if params[:employee_id].present?
          funds = funds.where(employee_id: params[:employee_id])
        end

        if params[:donor_name].present?
          funds = funds.where(donor_name: params[:donor_name])
        end

        funds
      end

      def fund_params
        params.permit(:donor_name, :phone_number, :donation_amount, :employee_id)
      end
    end
  end
end
