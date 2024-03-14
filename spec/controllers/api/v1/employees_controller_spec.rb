require 'rails_helper'

RSpec.describe Api::V1::EmployeesController, type: :controller do
  let!(:employee) { FactoryBot.create(:employee) }

  def formatted_time(t)
    t.strftime("%FT%T.%LZ")
  end
  let(:expected_list_output) do
    [
      {
        'id' => employee.id,
        'name' => employee.name,
        'image' => employee.image,
        'percentage_raised' => employee.percentage_raised.to_s,
        'target_amount' => employee.target_amount.to_s,
        'province' => employee.province,
        'created_at' => formatted_time(employee.created_at),
        'updated_at' => formatted_time(employee.updated_at),
      }
    ]
  end

  describe 'GET #index' do
    context 'json responses' do
      it 'returns all employees' do
        get :index, params: { format: :json }

        expect(JSON.parse(response.body)).to eq(expected_list_output)
      end
    end

    context 'with filter params' do
      let(:filtered_param_expected_output) do
        [
          {
            'id' => employee.id,
            'name' => employee.name,
            'image' => employee.image,
            'percentage_raised' => employee.percentage_raised.to_s,
            'province' => employee.province,
            'target_amount' => employee.target_amount.to_s,
            'created_at' => formatted_time(employee.created_at),
            'updated_at' => formatted_time(employee.updated_at),
          },
        ]
      end
      it 'returns only filtered employee' do
        get :index, params: { province: 'Quebec', format: :json }

        expect(JSON.parse(response.body)).to eq(filtered_param_expected_output)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) do
        {
          name: 'Zamal',
          image: 'www.image.com',
          target_amount: '200.0',
          province: 'Quebec',
        }
      end


      it 'creates a new employee' do
        expect { post :create, params: valid_attributes }.to change(Employee, :count).by(1)
      end

      let(:expected_output) do
        {
          'data' => {
            'id' => Employee.last.id,
            'name' => valid_attributes[:name],
            'image' => valid_attributes[:image],
            'percentage_raised' => '0.0',
            'target_amount' => valid_attributes[:target_amount],
            'province' => valid_attributes[:province],
            'created_at' => formatted_time(Employee.last.created_at),
            'updated_at' => formatted_time(Employee.last.updated_at),
          },
          'status' => 'SUCCESS'
        }
      end

      it 'format JSON' do
        post :create, params: valid_attributes.merge(format: :json)
        expect(response.status).to eq 201
        expect(JSON.parse(response.body)).to eq(expected_output)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) do
        {
          name: nil,
          target_amount: nil,
          province: 'Quebec',
        }
      end

      let(:output_with_error) do
        {
          'data' => {
            'name' => ["can't be blank"],
            'target_amount' => ["can't be blank"],
          },
          'status' => 'ERROR'
        }
      end

      it 'does not create an fund' do
        expect { post :create, params: invalid_attributes }.not_to change(Employee, :count)
      end

      it 'shows error messages' do
        post :create, params: invalid_attributes.merge(format: :json)

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)).to eq(output_with_error)
      end
    end
  end
end
