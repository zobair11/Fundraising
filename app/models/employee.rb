class Employee < ApplicationRecord
  has_many :funds, dependent: :destroy

  validates :name, :target_amount, :percentage_raised, :province, presence: true
  validates_uniqueness_of :name
end
