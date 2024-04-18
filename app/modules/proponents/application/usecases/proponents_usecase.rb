# frozen_string_literal: true

require_relative '../../domain/usecases/proponents_usecase_if'
require_relative '../../infrastructure/queries/proponents_query'
require_relative '../../infrastructure/repositories/proponents_repository'
require_relative '../../infrastructure/workers/update_salary_worker'
require_relative '../../domain/models/proponent'
require_relative '../../domain/models/phone'
require_relative '../../domain/value_objects/address'

module Proponents
  module Application
    module Usecases
      class ProponentsUsecase < Domain::Usecases::ProponentsUsecaseIF
        def initialize(repositories = {}, workers = {})
          super()
          @proponent_repository = repositories.fetch(:proponent) { Infrastructure::Repositories::ProponentsRepository.new }
          @update_salary_worker = workers.fetch(:update_salary) { Infrastructure::Workers::UpdateSalaryWorker }
        end

        def create_proponent(input)
          inss_discount = input.salary - calculate_inss_discount({ salary: input.salary })
          proponent = Domain::Models::Proponent.new(
            {
              name: input.name,
              cpf: input.cpf,
              date_of_birth: input.date_of_birth,
              salary: inss_discount,
              address: Domain::ValueObjects::Address.new(
                {
                  street: input.address[:street],
                  number: input.address[:number],
                  district: input.address[:district],
                  city: input.address[:city],
                  uf: input.address[:uf],
                  zipcode: input.address[:zipcode]
                }
              ),
              phone: Domain::Models::Phone.new(
                {
                  number: input.phone[:number],
                  phone_type: input.phone[:phone_type]
                }
              )
            }
          )
          @proponent_repository.create(proponent)
        end

        def update_proponent(input)
          inss_discount = input.salary - calculate_inss_discount({ salary: input.salary })
          result = @proponent_repository.find_by_id({ id: input.id })
          return nil if result.blank?

          proponent = Domain::Models::Proponent.new(
            {
              id: input.id,
              name: input.name,
              cpf: input.cpf,
              date_of_birth: input.date_of_birth,
              salary: result.salary == input.salary ? result.salary : inss_discount,
              address: Domain::ValueObjects::Address.new(
                {
                  street: input.address[:street],
                  number: input.address[:number],
                  district: input.address[:district],
                  city: input.address[:city],
                  uf: input.address[:uf],
                  zipcode: input.address[:zipcode]
                }
              ),
              phone: Domain::Models::Phone.new(
                {
                  number: input.phone[:number],
                  phone_type: input.phone[:phone_type]
                }
              )
            }
          )
          @update_salary_worker.perform_async(proponent.id, proponent.salary)
          @proponent_repository.update(proponent)
        end

        def destroy_proponent(input)
          proponent = @proponent_repository.find_by_id({ id: input.id })
          return nil if proponent.blank?

          @proponent_repository.destroy(proponent)
        end

        def find_all_proponents
          Infrastructure::Queries::ProponentsQuery.find_all_proponents
        end

        def calculate_inss_discount(input)
          salary_ranges = [
            { range: 1045, rate: 0.075 },
            { range: 2089.6, rate: 0.09 },
            { range: 3134.4, rate: 0.12 },
            { range: 6101.06, rate: 0.14 }
          ]
          inss_discount = 0
          remaining_salary = input[:salary]
          salary_ranges.each do |range|
            break if remaining_salary <= 0

            range_max = range[:range]
            rate = range[:rate]
            if remaining_salary <= range_max
              inss_discount += remaining_salary * rate
              remaining_salary = 0
            else
              inss_discount += range_max * rate
              remaining_salary -= range_max
            end
          end
          inss_discount.round(2)
        end

        def filter_proponents_by_salary_range(input)
          salary_ranges = {
            "Até R$ 1.045,00" => (0..1045.00),
            "De R$ 1.045,01 a R$ 2.089,60" => (1045.01..2089.60),
            "De R$ 2.089,61 até R$ 3.134,40" => (2089.61..3134.40),
            "De R$ 3.134,41 até R$ 6.101,06" => (3134.41..6101.06)
          }
          proponents_by_salary_range = {}
          salary_ranges.each_with_index do |(range_name, range), index|
            page_param = input[:params]["salary_range_#{index}"]
            proponents_in_range = input[:proponents].where(salary: range).page(page_param).per(5)
            total_proponents = proponents_in_range.total_count
            proponents_by_salary_range[range_name] = {
              proponents: proponents_in_range,
              total: total_proponents
            }
          end
          proponents_by_salary_range
        end
      end
    end
  end
end
