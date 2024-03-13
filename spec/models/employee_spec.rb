require 'rails_helper'

RSpec.describe Employee, type: :model do
  it { is_expected.to have_many(:funds) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:percentage_raised) }
    it { should validate_presence_of(:target_amount) }
    it { should validate_presence_of(:province) }
  end
end
