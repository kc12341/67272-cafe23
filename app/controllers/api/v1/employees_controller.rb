module Api::V1
  class EmployeesController < ApiController
    
    before_action :set_employee, only: [:show]
    def index
        @employees = Employee.active.alphabetical.all
        render json: EmployeeSerializer.new(@employees).serialized_json
      end

     # GET
     def show
        render json: EmployeeSerializer.new(@employee).serialized_json
      end
    
      private
      # Use callbacks to share common setup or constraints between actions.
      def set_employee
        @employee = Employee.find(params[:id])
      end
    
  end
end