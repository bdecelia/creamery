class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :check_login

  def index
    @active_jobs = Job.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @inactive_jobs = Job.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
  end

  def new
    @job = Job.new
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      # if saved to database
      flash[:notice] = "Successfully created job."
      redirect_to jobs_path
    else
      # return to the 'new' form
      render action: 'new'
    end
  end

  def update
  	if @job.update(job_params)
      redirect_to job_path(@job), notice: "Successfully updated #{@job.name}."
    else
      render action: 'edit'
    end
  end
  
  def destroy
  	@job.destroy
    redirect_to jobs_path, notice: "Successfully removed #{@job.name} from the AMC system."
  end

  def show
  end

  private
  def job_params
    params.require(:job).permit(:id, :name, :description, :active)
  end

  def set_job
    @job = Job.find(params[:id])
  end

end