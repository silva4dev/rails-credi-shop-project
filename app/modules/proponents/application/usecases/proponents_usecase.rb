# frozen_string_literal: true

require_relative '../../domain/usecases/proponents_usecase_if'
require_relative '../../infrastructure/queries/proponents_query'

module Proponents
  module Application
    module Usecases
      class ProponentsUsecase < Domain::Usecases::ProponentsUsecaseIF
        def calculate_inss_discount(input)
          brackets = [
            { range: 1045.00, rate: 0.075 },
            { range: 2089.60, rate: 0.09 },
            { range: 3134.40, rate: 0.12 },
            { range: Float::INFINITY, rate: 0.14 }
          ]

          inss_discount = 0.0
          current_salary = input[:salary]

          brackets.each do |bracket|
            break unless current_salary.positive?

            range_max = [current_salary, bracket[:range]].min
            inss_discount += range_max * bracket[:rate]
            current_salary -= range_max
          end

          inss_discount.round(2)
        end

        def find_all_proponents_by_page(input)
          Infrastructure::Queries::ProponentsQuery.paginate_by(input[:page])
        end
      end
    end
  end
end
