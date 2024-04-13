# frozen_string_literal: true

module Proponents
  module Domain
    module Usecases
      class ProponentsUsecaseIF
        def find_all_proponents_by_page(input)
          raise NotImplementedError
        end

        def calculate_inss_discount(input)
          raise NotImplementedError
        end
      end
    end
  end
end
