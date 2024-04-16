# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponents::Infrastructure::Queries::ProponentsQuery, type: :query do
  describe '.find_all_proponents' do
    let(:proponents_query) { described_class }

    it 'returns all proponents' do
      create_list(:proponent, 10)
      result = proponents_query.find_all_proponents
      expect(result.count).to eq(10)
    end
  end
end
