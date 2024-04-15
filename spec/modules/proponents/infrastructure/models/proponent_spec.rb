# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponents::Infrastructure::Models::Proponent, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      proponent = build(:proponent)
      expect(proponent).to be_valid
    end

    it 'is not valid without a name' do
      proponent = build(:proponent, name: nil)
      expect(proponent).not_to be_valid
    end

    it 'is not valid without a valid CPF format' do
      proponent = build(:proponent, cpf: '12345678900')
      expect(proponent).not_to be_valid
    end

    it 'is not valid with a CPF that already exists' do
      existing_proponent = create(:proponent)
      proponent = build(:proponent, cpf: existing_proponent.cpf)
      expect(proponent).not_to be_valid
    end

    it 'is not valid with a date of birth in the future' do
      proponent = build(:proponent, date_of_birth: Date.tomorrow)
      expect(proponent).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to have_one(:address).dependent(:destroy) }
    it { is_expected.to have_one(:phone).dependent(:destroy) }
  end
end
