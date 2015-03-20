class Staff::CohortsController < ApplicationController
  before_action :authenticate_user!

 def index
    @cohorts = Cohort.all
  end

  def new
    @cohort = Cohort.new
  end

  def create
    @cohort = Cohort.create(cohort_params)
    if @cohort.save
      redirect_to staff_cohorts_path, notice: "Cohort successfully saved."
    else
      render :new, alert: "Cohort could not be saved."
    end
  end

  def edit
    @cohort = Cohort.find(params[:id])
  end

  def update
    @cohort = Cohort.find(params[:id])
    @cohort.update(cohort_params)
    if @cohort.save
      redirect_to staff_cohort_path
      flash[:notice] = "Cohort successfully updated."
    else
      render :edit
      flash[:notice] = "Cohort could not be updated."
    end
  end

  def show
    @cohort = Cohort.find(params[:id])
  end

  private

  def cohort_params
    params.require(:cohort).permit(:season, :start_date, :year)
  end

end
