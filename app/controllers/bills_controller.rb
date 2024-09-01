class BillsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?, only: %i[approve decline]
  before_action :set_bill, only: %i[show edit update destroy]

  def index
    if current_user.admin?
      @bills = Bill.all.order(created_at: :asc)
      @submitted_count = Bill.all.size
      @approved_count = Bill.all.by_approved.size
    elsif current_user.employee?
      @bills = current_user.bills.all.order(created_at: :asc)
      @submitted_count = current_user.bills.size
      @approved_count = current_user.bills.by_approved.size
    end
  end

  def show; end

  def new
    @bill = current_user.bills.new
  end

  def create
    @bill = current_user.bills.new(bill_params.merge(submission_date: Date.today))
    if @bill.save
      redirect_to bills_path, notice: 'Bill created successfully'
    else
      render :new
    end
  end

  def edit; end

  def update
    @bill.update(bill_params)
    if @bill
      redirect_to bills_path, notice: 'Bill updated successfully'
    else
      render :edit
    end
  end

  def destroy
    return if @bill.blank?

    @bill.destroy
    redirect_to bills_path, notice: 'Bill deleted successfully'
  end

  def approve
    @bill = Bill.find(params[:id])
    if @bill.update(status: Bill.statuses[:approved])
      redirect_to bills_path, notice: 'Bill approved successfully.'
    else
      redirect_to bills_path, alert: 'Failed to approve the bill.'
    end
  end

  def decline
    @bill = Bill.find(params[:id])
    if @bill.update(status: Bill.statuses[:rejected])
      redirect_to bills_path, notice: 'Bill declined successfully.'
    else
      redirect_to bills_path, alert: 'Failed to decline the bill.'
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:bill_type, :amount)
  end

  def set_bill
    @bill = current_user.bills.find_by(id: params[:id])
  end

  def is_admin?
    redirect_to bills_path notice: 'Access Denied' if current_user.employee_permission?
  end
end
