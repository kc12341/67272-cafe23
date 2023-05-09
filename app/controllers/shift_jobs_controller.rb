
class ShiftJobsController < ApplicationController
    before_action :set_shift_job, only: [:destroy]
    before_action :check_login

    def new
        @shift_job = ShiftJob.new
    end

    def create
        @shift_job = ShiftJob.new(shift_job_params)
        if @shift_job.save
            redirect_to shift_path(@shift_job.shift), notice: "Job successfully added to shift."
        else
            render action: 'new'
        end
    end


    def destroy
        if @shift_job.destroy
            redirect_to @shift_job.shift
        end
    end

    
    private
    def set_shift_job
        @shift_job = ShiftJob.find(params[:id])
    end
    
    def shift_job_params
        params.require(:shift_job).permit(:shift_id, :job_id)
    end
    
end
