# frozen_string_literal: true

require_relative '../app/modules/proponents/infrastructure/models/proponent'

10.times do
  Proponents::Infrastructure::Models::Proponent.create(
    name: Faker::Name.name,
    cpf: Faker::IdNumber.brazilian_citizen_number(formatted: true),
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    salary: Faker::Number.decimal(l_digits: 4, r_digits: 2),
    address_attributes: {
      street: Faker::Address.street_address,
      number: Faker::Address.building_number,
      district: Faker::Address.community,
      city: Faker::Address.city,
      uf: Faker::Address.state_abbr,
      zipcode: Faker::Address.zip_code
    },
    phone_attributes: {
      number: "+55 #{Faker::PhoneNumber.cell_phone}",
      phone_type: :personal
    }
  )
end
