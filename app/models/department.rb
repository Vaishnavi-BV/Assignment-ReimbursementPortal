class Department < ApplicationRecord
  validates :name, presence: { message: 'must be exists' }
  has_many :users
end
