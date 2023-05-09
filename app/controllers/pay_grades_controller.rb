
class PayGradesController < ApplicationController
    before_action :set_pay_grade, only: [:show, :edit, :update]
    before_action :check_login
    authorize_resource

      def index
      end
      
      def show
        @pay_grade_rate_history = @pay_grade.pay_grade_rates
      end
  
      def new
        @pay_grade = PayGrade.new
      end
  
      def edit
      end
  
      def create
        @pay_grade = PayGrade.new(pay_grade_params)
        if @pay_grade.save
          redirect_to pay_grades_url
        else
          render action: 'new'
        end
      end
    
  
      def update
        if @pay_grade.update(pay_grade_params)
          redirect_to pay_grades_url
        else
          render action: 'edit'
        end
      end
      
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_pay_grade
          @pay_grade = PayGrade.find(params[:id])
        end
  
        # Only allow a trusted parameter "white list" through.
        def pay_grade_params
          params.require(:pay_grade).permit(:level, :active)
        end

end