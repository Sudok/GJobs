class JobsController < ApplicationController
  before_action :set_job, only: %i[ show update destroy ]
  before_action :authenticate_recruiter_login!, only: %i[ create update destroy ]

  # GET /jobs
  # GET /jobs.json
  def index
    if params[:query].present?
      @jobs = Job.search_jobs(params[:query])
    else
      @jobs = Job.active
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    if @job.save
      render :show, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    if @job.update(job_params)
      render :show, status: :ok, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
  end

  private
    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:title, :description, :start_date, :end_date, :status, :skills, :recruiter_id)
    end
end
