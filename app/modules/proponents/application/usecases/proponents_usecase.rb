# frozen_string_literal: true

require_relative '../../domain/usecases/proponents_usecase_if'
require_relative '../../infrastructure/queries/proponents_query'
require_relative '../../infrastructure/repositories/proponents_repository'
require_relative '../../domain/models/proponent'
require_relative '../../domain/models/phone'
require_relative '../../domain/value_objects/address'

module Proponents
  module Application
    module Usecases
      class ProponentsUsecase < Domain::Usecases::ProponentsUsecaseIF
        def initialize(repositories = {})
          super()
          @proponent_repository = repositories.fetch(:proponent) do
            Proponents::Infrastructure::Repositories::ProponentsRepository.new
          end
        end

        def find_all_proponents_by_page(input)
          Infrastructure::Queries::ProponentsQuery.paginate_by({ page: input[:page] })
        end

        def create_proponent(input)
          proponent = Domain::Models::Proponent.new(
            {
              name: input.name,
              cpf: input.cpf,
              date_of_birth: input.date_of_birth,
              salary: input.salary,
              address: Proponents::Domain::ValueObjects::Address.new(
                {
                  street: input.address[:street],
                  number: input.address[:number],
                  district: input.address[:district],
                  city: input.address[:city],
                  uf: input.address[:uf],
                  zipcode: input.address[:zipcode]
                }
              ),
              phone: Proponents::Domain::Models::Phone.new(
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
          return nil if @proponent_repository.find_by({ id: input.id }).blank?

          proponent = Domain::Models::Proponent.new(
            {
              id: input.id,
              name: input.name,
              cpf: input.cpf,
              date_of_birth: input.date_of_birth,
              salary: input.salary,
              address: Proponents::Domain::ValueObjects::Address.new(
                {
                  street: input.address[:street],
                  number: input.address[:number],
                  district: input.address[:district],
                  city: input.address[:city],
                  uf: input.address[:uf],
                  zipcode: input.address[:zipcode]
                }
              ),
              phone: Proponents::Domain::Models::Phone.new(
                {
                  number: input.phone[:number],
                  phone_type: input.phone[:phone_type]
                }
              )
            }
          )
          @proponent_repository.update(proponent)
        end

        def destroy_proponent(input)
          proponent = @proponent_repository.find_by({ id: input.id })
          return nil if proponent.blank?

          @proponent_repository.destroy(proponent)
        end
      end
    end
  end
end
