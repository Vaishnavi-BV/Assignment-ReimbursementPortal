class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :first_name, :role

  belongs_to :department
  has_many :bills, dependent: :destroy

  enum role: {
    admin: 'Admin',
    employee: 'Employee'
  }



  def full_name
    first_name + ' ' + last_name
  end

  def admin_permission?
    self.role.downcase == 'admin'
  end

  def employee_permission?
    self.role.downcase == 'employee'
  end
end
