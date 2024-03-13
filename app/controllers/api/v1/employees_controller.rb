module Api
  module V1
    class EmployeesController < ApplicationController
      def index
        employee = filter_list(Employee.all)
        render json: employee, status: :ok
      end

      def create
        employee = Employee.new(employee_params)
        if employee.save
          render json: { status: 'SUCCESS', data: employee }, status: :created
        else
          render json: { status: 'ERROR', data: employee.errors }, status: :unprocessable_entity
        end
      end

      private

      def filter_list(employees)
        if params[:province].present?
          employees = employees.where(province: params[:province])
        end

        employees
      end

      def employee_params
        params.permit(:name, :image, :percentage_raised, :target_amount, :province)
      end
    end
  end
end
