# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponents::Domain::ValueObjects::Address do
  describe '#initialize' do
    context 'with valid attributes' do
      let(:address_attributes) do
        {
          street: '123 Main St',
          number: '1A',
          district: 'Downtown',
          city: 'Exampleville',
          uf: 'EX',
          zipcode: '12345-678'
        }
      end

      it 'creates a new address object' do
        address = described_class.new(address_attributes)

        expect(address).to be_a(described_class)
        expect(address.street).to eq('123 Main St')
        expect(address.number).to eq('1A')
        expect(address.district).to eq('Downtown')
        expect(address.city).to eq('Exampleville')
        expect(address.uf).to eq('EX')
        expect(address.zipcode).to eq('12345-678')
      end
    end
  end
end
