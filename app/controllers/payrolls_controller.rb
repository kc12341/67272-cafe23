class PayrollsController < ApplicationController
    def store_form
        # employees wouldn't even be able to see this so no need to include 
        # authorize! :store_form, :payrolls_controller
        if current_employee.manager_role? 
            @stores = current_employee.current_assignment.store
        else 
            @stores = Store.active.alphabetical.all
        end
    end

    def employee_form
        # authorize! :employee_form, :payrolls_controller
        if current_employee.manager_role? 
            redirect_to home_path
        end
        @employees = Employee.active.alphabetical.all
    end

    def employee_payroll
        @range = DateRange.new(params[:start_date].to_date, params[:end_date].to_date)
        @calculator = PayrollCalculator.new(@range)
        @employee = Employee.find(params[:employee_id])
        @employee_payroll = @calculator.create_payroll_record_for(@employee)
    end 

    def store_payroll
        if current_employee.admin_role? 
            @range = DateRange.new(params[:start_date].to_date, params[:end_date].to_date)
            @calculator = PayrollCalculator.new(@range)
            @store = Store.find(params[:store_id])
            @store_payroll = @calculator.create_payrolls_for(@store)
        elsif current_employee.manager_role?
            @range = DateRange.new(params[:start_date].to_date, params[:end_date].to_date)
            @calculator = PayrollCalculator.new(@range)
            @store = current_employee.current_assignment.store
            @store_payroll = @calculator.create_payrolls_for(@store)
        end
    end 
end