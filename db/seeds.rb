# frozen_string_literal: true

10.times do
  Proponent.create(
    name: Faker::Name.name,
    cpf: Faker::IdNumber.brazilian_citizen_number(formatted: true),
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    salary: Faker::Number.decimal(l_digits: 4, r_digits: 2)
  )
end
