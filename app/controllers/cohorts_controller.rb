class CohortsController < ApplicationController
 def index
    @cohorts = Cohort.all
  end

  def new
    @cohort = Cohort.new
  end

  def create
    @cohort = Cohort.create(cohort_params)
    if @cohort.save
      redirect_to cohorts_path, notice: "Cohort successfully saved."
    else
      render :new, alert: "Fellow could not be saved."
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
