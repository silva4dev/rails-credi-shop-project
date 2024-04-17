# frozen_string_literal: true

module Proponents
  module Domain
    module Repositories
      class ProponentsRepositoryIF
        def create(input)
          raise NotImplementedError
        end

        def find_by_id(input)
          raise NotImplementedError
        end

        def destroy(input)
          raise NotImplementedError
        end

        def update(input)
          raise NotImplementedError
        end
      end
    end
  end
end
