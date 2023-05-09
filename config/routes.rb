Rails.application.routes.draw do
  # API routing
  scope module: 'api', defaults: {format: 'json'} do
    namespace :v1 do
      # provide the routes for the API here

     

    end
  end

  # Routes for regular HTML views go here...
  
  resources :stores, except: [:destroy]
  resources :assignments
  resources :pay_grades, except: [:destroy]
  resources :sessions
  resources :employees
  resources :jobs, except: [:show]
  resources :shifts
  
   # Semi-static page routes
   get 'home', to: 'home#index', as: :home
   get 'home/about', to: 'home#about', as: :about
   get 'home/contact', to: 'home#contact', as: :contact
   get 'home/privacy', to: 'home#privacy', as: :privacy
   get 'home/search', to: 'home#search', as: :search
   
   # authentication routes
   get 'employees/new', to: 'employees#new', as: :signup
   get 'employee/edit', to: 'employees#edit', as: :edit_current_employee
   get 'login', to: 'sessions#new', as: :login
   get 'logout', to: 'sessions#destroy', as: :logout

   # custom routes
   get 'pay_grade_rates/new', to: 'pay_grade_rates#new', as: :new_pay_grade_rate
   post 'pay_grade_rates', to: 'pay_grade_rates#create', as: :pay_grade_rates

   get 'shift_jobs/new', to: 'shift_jobs#new', as: :new_shift_job
   post 'shift_jobs', to: 'shift_jobs#create', as: :shift_jobs
   delete 'shift_jobs/:id', to: 'shift_jobs#destroy', as: :shift_job

   get 'time_clock', to: 'shifts#time_clock', as: :time_clock
   patch 'time_in', to: 'shifts#time_in', as: :time_in
   patch 'time_out', to: 'shifts#time_out', as: :time_out

   get 'store_form', to: 'payrolls#store_form', as: :store_form
   get 'employee_form', to: 'payrolls#employee_form', as: :employee_form
   get 'store_payroll', to: 'payrolls#store_payroll', as: :store_payroll
   get 'employee_payroll', to: 'payrolls#employee_payroll', as: :employee_payroll
   
   



  # You can have the root of your site routed with 'root'
  root 'home#index'
  
end
