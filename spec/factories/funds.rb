FactoryBot.define do
  factory :fund do
    sequence(:name) { |n| "Zobair Islam_#{n}" }
    donor_name { 'John Cena' }
    phone_number { '4383311111' }
    donation_amount { 10.0 }
    employee
  end
end
