# frozen_string_literal: true

require_relative '../../domain/queries/proponents_query_if'

module Proponents
  module Infrastructure
    module Queries
      class ProponentsQuery < Domain::Queries::ProponentsQueryIF
        class << self
          def paginate_by(page)
            Models::Proponent.page(page).per(5)
          end
        end
      end
    end
  end
end
