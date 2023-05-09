
class HomeController < ApplicationController
  def index
    # variables needed for upcoming and past shift partials

    if current_employee && current_employee.employee_role?
      @upcoming_shifts = Shift.all.upcoming.for_employee(current_employee)
      @past_shifts = Shift.all.past.for_employee(current_employee)
    end

    # variables needed for payroll template
    if current_employee && current_employee.manager_role? 
      @shift = Shift.new
      @stores = current_employee.current_assignment.store
    else 
      @stores = Store.active.alphabetical.all
    end

    if current_employee && current_employee.admin_role?
      @employees = Employee.active.alphabetical.all
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end
end