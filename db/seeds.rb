Employee.create(
  [ {
      name: Faker::Name.name,
      image: Faker::Avatar.image,
      target_amount: Faker::Number.number(digits: 3),
      province: 'Quebec'
    },
    {
      name: Faker::Name.name,
      image: Faker::Avatar.image,
      target_amount: Faker::Number.number(digits: 3),
      province: 'Ontario'
    }
  ]
)
