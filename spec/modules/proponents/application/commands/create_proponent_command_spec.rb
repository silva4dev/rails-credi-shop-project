# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponents::Application::Commands::CreateProponentCommand do
  describe '#initialize' do
    it 'initializes with the correct attributes' do
      input = {
        name: 'John Doe',
        cpf: '123.456.789-00',
        date_of_birth: Date.new(1980, 1, 1),
        salary: 5000.0,
        address_attributes: {
          street: '123 Main St',
          number: '1A',
          district: 'Downtown',
          city: 'Exampleville',
          uf: 'EX',
          zipcode: '12345-678'
        },
        phone_attributes: {
          number: '+55 (19) 99337-4443',
          phone_type: 'personal'
        }
      }
      command = described_class.new(input)

      expect(command.name).to eq('John Doe')
      expect(command.cpf).to eq('123.456.789-00')
      expect(command.date_of_birth).to eq(Date.new(1980, 1, 1))
      expect(command.salary).to eq(5000.0)
      expect(command.address).to eq(
        street: '123 Main St',
        number: '1A',
        district: 'Downtown',
        city: 'Exampleville',
        uf: 'EX',
        zipcode: '12345-678'
      )
      expect(command.phone).to eq(
        number: '+55 (19) 99337-4443',
        phone_type: 'personal'
      )
    end
  end
end
