# frozen_string_literal: true

require_relative '../../domain/queries/proponents_query_if'
require_relative '../models/proponent'

module Proponents
  module Infrastructure
    module Queries
      class ProponentsQuery < Domain::Queries::ProponentsQueryIF
        class << self
          def find_all_proponents
            Models::Proponent.all
          end
        end
      end
    end
  end
end
