# frozen_string_literal: true

require_relative '../../domain/repositories/proponents_repository_if'
require_relative '../models/proponent'
require 'pry-remote'

module Proponents
  module Infrastructure
    module Repositories
      class ProponentsRepository < Domain::Repositories::ProponentsRepositoryIF
        def create(input)
          proponent = Models::Proponent.new(
            name: input.name,
            cpf: input.cpf,
            date_of_birth: input.date_of_birth,
            salary: input.salary,
            phone_attributes: {
              number: input.phone.number,
              phone_type: input.phone.phone_type
            },
            address_attributes: {
              street: input.address.street,
              number: input.address.number,
              district: input.address.district,
              city: input.address.city,
              uf: input.address.uf,
              zipcode: input.address.zipcode
            }
          )
          proponent.save
          proponent
        end

        def find_by_id(input)
          Models::Proponent.find_by(id: input[:id])
        end

        def destroy(input)
          proponent = Models::Proponent.find(input.id)
          proponent.destroy
          proponent
        end

        def update(input)
          proponent = Models::Proponent.find(input.id)
          proponent.update(
            name: input.name,
            cpf: input.cpf,
            date_of_birth: input.date_of_birth,
            phone_attributes: {
              number: input.phone.number,
              phone_type: input.phone.phone_type
            },
            address_attributes: {
              street: input.address.street,
              number: input.address.number,
              district: input.address.district,
              city: input.address.city,
              uf: input.address.uf,
              zipcode: input.address.zipcode
            }
          )
          proponent
        end

        def update_by_salary(input)
          proponent = Models::Proponent.find(input[:id])
          proponent.update(salary: input[:salary])
        end
      end
    end
  end
end
