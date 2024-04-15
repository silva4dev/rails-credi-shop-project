# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponents::Infrastructure::Models::Phone, type: :model do
  subject(:phone) { build(:phone) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:phone_type) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:proponent) }
  end

  describe 'validations formats' do
    context 'with correct formats' do
      it { is_expected.to allow_value(phone.number).for(:number) }
    end

    context 'with incorrect formats' do
      it { is_expected.not_to allow_value('incorrect_number').for(:number) }
    end
  end
end
