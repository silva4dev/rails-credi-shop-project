# frozen_string_literal: true

module Proponents
  module Domain
    module Queries
      class ProponentsQueryIF
        def paginate_by(page)
          raise NotImplementedError
        end
      end
    end
  end
end
