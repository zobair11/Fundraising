require 'rails_helper'

RSpec.describe Fund, type: :model do
  it { is_expected.to belong_to(:employee) }

  describe 'validations' do
    it { should validate_presence_of(:donor_name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:donation_amount) }
  end
end
