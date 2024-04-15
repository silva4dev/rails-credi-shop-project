# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponents::Infrastructure::Models::Address, type: :model do
  subject(:address) { build(:address) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:district) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:uf) }
    it { is_expected.to validate_presence_of(:zipcode) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:proponent) }
  end

  describe 'validations formats' do
    context 'with correct formats' do
      it { is_expected.to allow_value(address.zipcode).for(:zipcode) }
    end

    context 'with incorrect formats' do
      it { is_expected.not_to allow_value('incorrect_zipcode').for(:zipcode) }
    end
  end
end
