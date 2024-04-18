# frozen_string_literal: true

module Proponents
  module Domain
    module Usecases
      class ProponentsUsecaseIF
        def find_all_proponents
          raise NotImplementedError
        end

        def create_proponent(input)
          raise NotImplementedError
        end

        def calculate_inss_discount(input)
          raise NotImplementedError
        end

        def filter_proponents_by_salary_range(input)
          raise NotImplementedError
        end

        def destroy_proponent(input)
          raise NotImplementedError
        end

        def update_proponent(input)
          raise NotImplementedError
        end
      end
    end
  end
end
