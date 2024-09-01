class DepartmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  before_action :set_department, only: %i[edit update destroy]

  def index
    @departments = Department.all.order(created_at: :asc)
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to departments_path, notice: 'Department created successfully'
    else
      render :new
    end
  end

  def edit; end

  def update
    @department.update(department_params)
    if @department
      redirect_to departments_path, notice: 'Department updated successfully'
    else
      render :edit
    end
  end

  def destroy
    return if @department.blank?

    @department.destroy
    redirect_to departments_path, notice: 'Department deleted successfully'
  end

  private

  def department_params
    params.require(:department).permit(:name, :description)
  end

  def set_department
    @department = Department.find(params[:id])
  end

  def is_admin?
    redirect_to root_path notice: 'Access Denied' if current_user.employee_permission?
  end
end
