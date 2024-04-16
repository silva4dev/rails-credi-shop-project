# frozen_string_literal: true

module Proponents
  module Domain
    module Queries
      class ProponentsQueryIF
        def find_all_proponents(input)
          raise NotImplementedError
        end
      end
    end
  end
end
