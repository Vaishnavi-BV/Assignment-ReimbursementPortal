class Bill < ApplicationRecord
  validates_presence_of :amount, :bill_type

  belongs_to :user

  scope :by_approved, -> { where(status: self.statuses[:approved])}

  enum status: {
    pending: 'pending',
    approved: 'approved',
    rejected: 'rejected'
  }

  enum bill_type: {
    food: 'Food',
    travel: 'Travel'
  }
end
