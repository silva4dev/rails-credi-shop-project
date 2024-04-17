# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponents::Infrastructure::Repositories::ProponentsRepository, type: :repository do
  describe '#create' do
    it 'creates a new proponent' do
      proponent = Proponents::Domain::Models::Proponent.new(
        {
          name: 'John Doe',
          cpf: '123.456.789-00',
          date_of_birth: Date.new(1980, 1, 1),
          salary: 5000.00,
          address: Proponents::Domain::ValueObjects::Address.new(
            {
              street: '123 Main St',
              number: '100',
              district: 'Downtown',
              city: 'Example City',
              uf: 'EX',
              zipcode: '12345-678'
            }
          ),
          phone: Proponents::Domain::Models::Phone.new(
            {
              number: '+55 (19) 99449-4444',
              phone_type: 'personal'
            }
          )
        }
      )
      repository = described_class.new
      output = repository.create(proponent)
      expect(output.name).to eq('John Doe')
      expect(output.cpf).to eq('123.456.789-00')
      expect(output.date_of_birth).to eq(Date.new(1980, 1, 1))
      expect(output.salary).to eq(5000.00)
      expect(output.phone.number).to eq('+55 (19) 99449-4444')
      expect(output.phone.phone_type).to eq('personal')
      expect(output.address.street).to eq('123 Main St')
      expect(output.address.number).to eq('100')
      expect(output.address.district).to eq('Downtown')
      expect(output.address.city).to eq('Example City')
      expect(output.address.uf).to eq('EX')
      expect(output.address.zipcode).to eq('12345-678')
    end
  end

  describe '#find_by_id' do
    it 'finds a proponent by ID' do
      Proponents::Infrastructure::Models::Proponent.create(
        id: 1,
        name: 'Jane Smith',
        cpf: '987.654.321-00',
        date_of_birth: Date.new(1990, 3, 15),
        salary: 6000.00
      )

      repository = described_class.new
      proponent = repository.find_by_id(id: 1)
      expect(proponent.name).to eq('Jane Smith')
      expect(proponent.cpf).to eq('987.654.321-00')
      expect(proponent.date_of_birth).to eq(Date.new(1990, 3, 15))
      expect(proponent.salary).to eq(6000.00)
    end
  end

  describe '#destroy' do
    it 'destroys a proponent by ID' do
      Proponents::Infrastructure::Models::Proponent.create(
        id: 1,
        name: 'Jane Smith',
        cpf: '987.654.321-00',
        date_of_birth: Date.new(1990, 3, 15),
        salary: 6000.00
      )
      repository = described_class.new
      proponent = repository.find_by_id(id: 1)
      expect(proponent).not_to be_nil
      repository.destroy(proponent)
      proponent = repository.find_by_id(id: 1)
      expect(proponent).to be_nil
    end
  end

  describe '#update' do
    it 'updates a proponent by ID' do
      Proponents::Infrastructure::Models::Proponent.create(
        id: 1,
        name: 'Jane Smith',
        cpf: '987.654.321-00',
        date_of_birth: Date.new(1990, 3, 15),
        salary: 6000.00,
        phone_attributes: {
          number: '+55 (19) 99449-4444',
          phone_type: 'personal'
        },
        address_attributes: {
          street: '123 Main St',
          number: '100',
          district: 'Downtown',
          city: 'Example City',
          uf: 'EX',
          zipcode: '12345-678'
        }
      )
      proponent = Proponents::Domain::Models::Proponent.new(
        id: 1,
        name: 'Jane Smith Updated',
        cpf: '987.654.321-00',
        date_of_birth: Date.new(1990, 3, 15),
        salary: 8000.00,
        address: Proponents::Domain::ValueObjects::Address.new(
          street: '123 Main St Updated',
          number: '100',
          district: 'Downtown Updated',
          city: 'Example City Updated',
          uf: 'EX',
          zipcode: '12345-678'
        ),
        phone: Proponents::Domain::Models::Phone.new(
          number: '+55 (19) 99449-4444',
          phone_type: 'personal'
        )
      )
      repository = described_class.new
      output = repository.update(proponent)
      expect(output).to be_valid
      expect(output.name).to eq('Jane Smith Updated')
      expect(output.salary).to eq(8000.00)
      expect(output.address.street).to eq('123 Main St Updated')
      expect(output.address.district).to eq('Downtown Updated')
      expect(output.address.city).to eq('Example City Updated')
    end
  end
end
