class Fund < ApplicationRecord
  belongs_to :employee

  validates :donor_name, presence: true
  validates :phone_number, :employee_id, presence: true
  validates :donation_amount, presence: true
end
