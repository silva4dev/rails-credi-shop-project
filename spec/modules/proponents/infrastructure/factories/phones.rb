# frozen_string_literal: true

FactoryBot.define do
  factory :phone, class: 'Proponents::Infrastructure::Models::Phone' do
    number { "+55 #{Faker::PhoneNumber.cell_phone}" }
    phone_type { :personal }
    proponent { association :proponent }
  end
end
