class Employee < ApplicationRecord
  has_many :funds, dependent: :destroy

  validates :name, :target_amount, :percentage_raised, :province, presence: true
  validates_uniqueness_of :name

  def total_raised_amount
    funds.map(&:donation_amount).inject(0, &:+)
  end
end
