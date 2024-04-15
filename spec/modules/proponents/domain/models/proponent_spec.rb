# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponents::Domain::Models::Proponent, type: :domain_model do
  describe '#initialize' do
    context 'with valid attributes' do
      let(:phone) { Proponents::Domain::Models::Phone.new({ number: '+55 (19) 99337-4443', phone_type: 'personal' }) }
      let(:address) { Proponents::Domain::ValueObjects::Address.new(street: '123 Main St', city: 'Exampleville', uf: 'EX', zipcode: '12345-678') }
      let(:proponent_attributes) do
        {
          name: 'John Doe',
          cpf: '123.456.789-00',
          date_of_birth: Date.new(1980, 1, 1),
          salary: 5000.0,
          phone:,
          address:
        }
      end

      it 'creates a new proponent object' do
        proponent = described_class.new(proponent_attributes)

        expect(proponent).to be_a(described_class)
        expect(proponent.id).to be_a(String).and match(/\A[\w-]+\z/) # UUID format
        expect(proponent.name).to eq('John Doe')
        expect(proponent.cpf).to eq('123.456.789-00')
        expect(proponent.date_of_birth).to eq(Date.new(1980, 1, 1))
        expect(proponent.salary).to eq(5000.0)
        expect(proponent.phone).to be_an_instance_of(Proponents::Domain::Models::Phone)
        expect(proponent.address).to be_an_instance_of(Proponents::Domain::ValueObjects::Address)
      end
    end
  end
end
