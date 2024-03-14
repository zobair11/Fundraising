require 'rails_helper'

RSpec.describe Employee, type: :model do
  it { is_expected.to have_many(:funds) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:target_amount) }
    it { should validate_presence_of(:province) }
  end


  describe '#total_raised_amount' do
    let(:amount_1) { 10 }
    let(:amount_2) { 15 }
    let(:total) { amount_1 + amount_2 }
    let(:employee) { FactoryBot.create(:employee) }
    let!(:fund_1) { FactoryBot.create(:fund, donation_amount:amount_1, employee: employee) }
    let!(:fund_2) { FactoryBot.create(:fund, donation_amount: amount_2, employee: employee) }

    it 'should return total invested amount' do
      expect(employee.total_raised_amount).to eq(total)
    end
  end
end
