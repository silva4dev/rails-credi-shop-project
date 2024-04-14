# frozen_string_literal: true

module Proponents
  module Application
    module Commands
      class UpdateProponentCommand
        attr_reader :id, :name, :cpf, :date_of_birth, :salary, :address, :phone

        def initialize(input)
          @id = input[:id]
          @name = input[:name]
          @cpf = input[:cpf]
          @date_of_birth = input[:date_of_birth]
          @salary = input[:salary]
          @address = input[:address_attributes].transform_keys(&:to_sym)
          @phone = input[:phone_attributes].transform_keys(&:to_sym)
        end
      end
    end
  end
end
