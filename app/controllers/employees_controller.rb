
class EmployeesController < ApplicationController
    before_action :set_employee, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

      # SHOW /employees
      def index
        if current_employee.admin_role?
            @active_employees = Employee.all.active
            @inactive_employees = Employee.all.inactive
        end

        if current_employee.manager_role?
            @active_employees = current_employee.current_assignment.store.employees.active
            @inactive_employees = current_employee.current_assignment.store.employees.inactive
        end
      end
      
      def show
        @current_assignment = @employee.current_assignment
        @other_assignments = @employee.assignments.past
      end
  
      def new
        @employee = Employee.new
      end
  
      def edit
        # @employee.assistant! if current_employee.assistant?
      end
  
      def create
        @employee = Employee.new(employee_params)
        # @employee.admin! if current_employee.admin_role?
        # @employee.manager! if current_employee.manager_role?
        # @employee.employee! if current_employee.employee_role?
        if @employee.save
          flash[:notice] = "Successfully added #{@employee.proper_name} as an employee."
          redirect_to @employee
        else
          render action: 'new'
        end
      end
    
  
      def update
        if @employee.update(employee_params)
          flash[:notice] = "Updated #{@employee.proper_name}'s information."
          redirect_to employee_url
        else
          render action: 'edit'
        end
      end
      
      def destroy
        if @employee.destroy
            redirect_to employees_url, notice: "Successfully removed #{@employee.proper_name}."
          ## There is no 'else' for now; we have no restrictions on user deletion (although we probably should)
        else
            render action: 'show'
        end
      end
  
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_employee
          @employee = Employee.find(params[:id])
        end
  
        # Only allow a trusted parameter "white list" through.
        def employee_params
          params.require(:employee).permit(:first_name, :last_name, :ssn, :phone, :date_of_birth, :role, :username, :password, :password_confirmation, :active)
        end

end