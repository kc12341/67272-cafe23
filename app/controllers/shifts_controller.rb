
class ShiftsController < ApplicationController
    before_action :set_shift, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

      def index
        if current_employee && current_employee.employee_role?
          @upcoming_shifts = Shift.all.upcoming.for_employee(current_employee)
          @past_shifts = Shift.all.past.for_employee(current_employee)
        elsif current_employee && current_employee.manager_role?
          @upcoming_shifts = Shift.all.upcoming.for_store(current_employee.current_assignment.store)
          @past_shifts = Shift.all.past.for_store(current_employee.current_assignment.store)
        else
          @upcoming_shifts = Shift.all.upcoming
          @past_shifts = Shift.all.past
        end
      end
      
      def show
        if current_employee && current_employee.employee_role?
          @upcoming_shifts = Shift.all.upcoming.for_employee(current_employee)
          @past_shifts = Shift.all.past.for_employee(current_employee)
        elsif current_employee && current_employee.manager_role?
          @upcoming_shifts = Shift.all.upcoming.for_store(current_employee.current_assignment.store)
          @past_shifts = Shift.all.past.for_store(current_employee.current_assignment.store)
        else
          @upcoming_shifts = Shift.all.upcoming
          @past_shifts = Shift.all.past
        end
      end
  
      def new
        @shift = Shift.new
      end

      def create
        @shift = Shift.new(shift_params)
        if @shift.save
          redirect_to @shift, notice: "Shift successfully added."
        else
          render action: 'new'
        end
      end
  
      def edit
      end  
  
      def update
        if @shift.update(shift_params)
          redirect_to @shift
        else
          render action: 'edit'
        end
      end
      
      def destroy
        if @shift.destroy
            redirect_to shifts_url
        else
            render action: 'show'
        end
      end

      def time_clock 
        range = DateRange.new(Date.current)
        @shift_today = current_employee.shifts.for_dates(range).first
        if @shift_today.nil?
          redirect_to home_path, notice: "You do not have any shifts today"
        end
      end

      def time_in
        range = DateRange.new(Date.current)
        @shift_today = current_employee.shifts.for_dates(range).first
        if @shift_today.nil?
          redirect_to home_path, notice: "You do not have any shifts today"
        else 
          @start_time_clock = TimeClock.new(@shift_today)
          @start_time_clock.start_shift_at()
          redirect_to home_path, notice: "Your shift has started."
        end
      end

      def time_out
        range = DateRange.new(Date.current)
        @shift_today = current_employee.shifts.for_dates(range).first
        if @shift_today.nil? || @shift_today.status != "started"
          redirect_to home_path, notice: "You do not have any shifts today"
        else 
          @start_time_clock = TimeClock.new(@shift_today)
          @start_time_clock.end_shift_at()
          if @shift_today.end_time == @shift_today.start_time
            flash.alert = "Your end time cannot be the same as your start time."
            redirect_to home_path
          else
            redirect_to home_path, notice: "Your shift has ended."
          end
        end

      end
  
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_shift
          @shift = Shift.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def shift_params
          params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes, :status)
        end

end