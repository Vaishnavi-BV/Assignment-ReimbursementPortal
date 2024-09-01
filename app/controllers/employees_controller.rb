class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  before_action :set_employee, only: %i[show edit update destroy]

  def index
    @employees = User.all.order(created_at: :asc)
  end

  def show; end

  def new
    @employee = User.new
  end

  def create
    @employee = User.new(employee_params)
    if @employee.save!
      redirect_to employees_path, notice: 'Employee created successfully'
    else
      render :new
    end
  end

  def edit; end

  def update
    @employee.update(employee_params)
    if @employee
      redirect_to employees_path, notice: 'Employee updated successfully'
    else
      render :edit
    end
  end

  def destroy
    return  if @employee.blank?

    @employee.destroy
    redirect_to employees_path, notice: 'Employee deleted successfully'
  end

  private

  def employee_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :role, :designation, :department_id)
  end

  def set_employee
    @employee = User.find_by(id: params[:id])
  end

  def is_admin?
    redirect_to root_path notice: 'Access Denied' if current_user.employee_permission?
  end
end