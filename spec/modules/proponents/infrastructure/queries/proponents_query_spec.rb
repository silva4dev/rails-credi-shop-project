# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponents::Infrastructure::Queries::ProponentsQuery, type: :query do
  describe '.paginate_by' do
    let(:proponents_query) { described_class }

    it 'returns paginated proponents' do
      create_list(:proponent, 10)
      result = proponents_query.paginate_by(page: 1)
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.count).to eq(5)
    end
  end
end
