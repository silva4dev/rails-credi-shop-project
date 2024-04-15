# frozen_string_literal: true

FactoryBot.define do
  factory :proponent, class: 'Proponents::Infrastructure::Models::Proponent' do
    name { Faker::Name.name }
    cpf { Faker::IdNumber.brazilian_citizen_number(formatted: true) }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65).ago(rand(18..65).years) }
    salary { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
  end
end
