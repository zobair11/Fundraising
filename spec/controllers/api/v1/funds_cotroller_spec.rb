require 'rails_helper'

RSpec.describe Api::V1::FundsController, type: :controller do
  let(:employee) { FactoryBot.create(:employee) }

  def formatted_time(t)
    t.strftime("%FT%T.%LZ")
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) do
        {
          donor_name: 'Hasan',
          phone_number: '4342212334',
          donation_amount: '10.0',
          employee_id: employee.id,
        }
      end


      it 'creates a new fund' do
        expect { post :create, params: valid_attributes }.to change(Fund, :count).by(1)
      end

      let(:expected_output) do
        {
          "data" => {
            "id" => Fund.first.id,
            "donor_name" => valid_attributes[:donor_name],
            "donation_amount" => valid_attributes[:donation_amount],
            "phone_number" => valid_attributes[:phone_number],
            "employee_id" => employee.id,
            "created_at" => formatted_time(Fund.last.created_at),
            "updated_at" => formatted_time(Fund.last.updated_at),
          },
          "status" => "SUCCESS"
        }
      end

      it 'format JSON' do
        post :create, params: valid_attributes.merge(format: :json)
        expect(response.status).to eq 201
        expect(JSON.parse(response.body)).to eq(expected_output)
      end

      it 'updates Employee Percentage Raised after successfully save' do
        expect(UpdateFundPercentageRaised).to receive(:call).with(employee)
        post :create, params: valid_attributes
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) do
        {
          donor_name: nil,
          donation_amount: nil,
          employee_id: employee.id,
        }
      end

      let(:output_with_error) do
        {
          "data" => {
            "donation_amount" => ["can't be blank"],
            "donor_name" => ["can't be blank"],
            "phone_number" => ["can't be blank"]
          },
          "status" => "ERROR"
        }
      end

      it 'does not create an fund' do
        expect { post :create, params: invalid_attributes }.not_to change(Fund, :count)
      end

      it 'shows error messages' do
        post :create, params: invalid_attributes.merge(format: :json)

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)).to eq(output_with_error)
      end
    end
  end
end
