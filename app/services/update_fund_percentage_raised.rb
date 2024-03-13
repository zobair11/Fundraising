class UpdateFundPercentageRaised
  attr_reader :employee

  def self.call(employee)
    new(employee).call
  end

  def initialize(employee)
    @employee = employee
  end

  def call
    target_amount = employee.target_amount
    total_raised_amount = employee.total_raised_amount
    percentage = (total_raised_amount / target_amount) * 100

    employee.update!(percentage_raised: percentage)
  end
end