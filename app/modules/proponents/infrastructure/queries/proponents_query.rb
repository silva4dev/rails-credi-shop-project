# frozen_string_literal: true

require_relative '../../domain/queries/proponents_query_if'
require_relative '../models/proponent'

module Proponents
  module Infrastructure
    module Queries
      class ProponentsQuery < Domain::Queries::ProponentsQueryIF
        class << self
          def paginate_by(input)
            Models::Proponent.page(input[:page]).per(5)
          end
        end
      end
    end
  end
end
