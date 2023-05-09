
class JobsController < ApplicationController
    before_action :set_job, only: [:edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def index
    end

    def new
        @job = Job.new
    end

    def edit
    end

    def create
        @job = Job.new(job_params)
        if @job.save
            # flash[:notice] = "Successfully added #{@job.name} as a job."
            redirect_to jobs_url
        else
            render action: 'new'
        end
    end


    def update
        if @job.update(job_params)
            # flash[:notice] = "Updated job information for #{@job.name}."
            redirect_to jobs_url
          else
            render action: 'edit'
        end
    end

    def destroy
        if @job.destroy
            redirect_to jobs_url
          ## There is no 'else' for now; we have no restrictions on user deletion (although we probably should)
        else
            render action: 'index'
        end
      end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
        @job = Job.find(params[:id])
    end

    def job_params
        params.require(:job).permit(:name, :description, :active)
    end
    
end
