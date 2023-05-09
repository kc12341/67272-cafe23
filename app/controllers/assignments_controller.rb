
class AssignmentsController < ApplicationController
    before_action :set_assignment, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

      # SHOW /employees
      def index
        if current_employee.admin_role?
            @current_assignments = Assignment.all.current
            @past_assignments = Assignment.all.past
        end

        if current_employee.manager_role?
            @current_assignments = Assignment.for_store(current_employee.current_assignment.store).current
            @past_assignments = Assignment.for_store(current_employee.current_assignment.store).past
        end

        if current_employee.employee_role?
            @current_assignments = current_employee.assignments.current
            @past_assignments = current_employee.assignments.past
        end
      end
      
      def show
      end
  
      def new
        @assignment = Assignment.new
      end
  
      def create
        @assignment = Assignment.new(assignment_params)
        # @employee.admin! if current_employee.admin_role?
        # @employee.manager! if current_employee.manager_role?
        # @employee.employee! if current_employee.employee_role?
        if @assignment.save
          flash[:notice] = "Successfully added the assignment."
          redirect_to assignments_url
        else
          render action: 'new'
        end
      end

      def edit
        # @employee.assistant! if current_employee.assistant?
      end
  
      def update
        if @assignment.update(assignment_params)
          flash[:notice] = "Updated assignment information."
          redirect_to assignments_url
        else
          render action: 'edit'
        end
      end
      
      def destroy
        if @assignment.destroy
            redirect_to assignments_url, notice: "Removed assignment from the system."
          ## There is no 'else' for now; we have no restrictions on user deletion (although we probably should)
        else
            render action: 'show'
        end
      end
  
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_assignment
          @assignment = Assignment.find(params[:id])
        end
  
        # Only allow a trusted parameter "white list" through.
        def assignment_params
          params.require(:assignment).permit(:store_id, :employee_id, :start_date, :end_date, :pay_grade_id)
        end

end