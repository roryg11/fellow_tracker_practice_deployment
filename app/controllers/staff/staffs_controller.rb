class Staff::StaffsController < ApplicationController
  before_action :authenticate_user!

  def index
    @staff = Staff.all
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(staff_params.merge({password: "12345678", password_confirmation: "12345678"}))
    if @staff.save
      redirect_to staff_staffs_path, notice: "Staff successfully saved."
    else
      render :new, alert: "Staff could not be saved."
    end
  end

  def edit
    @staff = Staff.find(params[:id])
  end

  def update
    @staff = Staff.find(params[:id])
    @staff.update(staff_params)
    if @staff.save
      redirect_to staff_staffs_path
      flash[:notice] = "Staff successfully updated."
    else
      render :edit
      flash[:notice] = "Staff could not be updated."
    end
  end

  def show
    @staff = Staff.find(params[:id])
    @cohorts = Cohort.all
  end

  private

  def staff_params
    params.require(:staff).permit(:first_name, :last_name, :email, :role)
  end

  def set_staff
    @staff = Staff.find(params[:id])
  end
end
