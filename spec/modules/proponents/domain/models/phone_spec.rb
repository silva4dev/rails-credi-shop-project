# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponents::Domain::Models::Phone, type: :domain_model do
  describe '#initialize' do
    context 'with valid attributes' do
      let(:phone_attributes) do
        {
          number: '123456789',
          phone_type: 'cell'
        }
      end

      it 'creates a new phone object' do
        phone = described_class.new(**phone_attributes)

        expect(phone).to be_a(described_class)
        expect(phone.id).to be_a(String).and match(/\A[\w-]+\z/) # UUID format
        expect(phone.number).to eq('123456789')
        expect(phone.phone_type).to eq('cell')
      end
    end
  end
end
