FactoryBot.define do
  factory :employee do
    sequence(:name) { |n| "Zobair Islam_#{n}" }
    image { 'image/url' }
    percentage_raised { 0.0 }
    target_amount { 400.0 }
    province { 'Quebec' }
  end
end
