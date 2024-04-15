# frozen_string_literal: true

FactoryBot.define do
  factory :address, class: 'Proponents::Infrastructure::Models::Address' do
    street { Faker::Address.street_address }
    number { Faker::Address.building_number }
    district { Faker::Address.community }
    city { Faker::Address.city }
    uf { Faker::Address.state_abbr }
    zipcode { Faker::Address.zip_code }
    proponent { association :proponent }
  end
end
