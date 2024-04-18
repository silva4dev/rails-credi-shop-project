# frozen_string_literal: true

module Proponents
  module Application
    module Commands
      class CreateProponentCommand
        attr_reader :name, :cpf, :date_of_birth, :salary, :address, :phone

        def initialize(input)
          @name = input[:name]
          @cpf = input[:cpf]
          @date_of_birth = input[:date_of_birth]
          @salary = input[:salary].to_f
          @address = input[:address_attributes]
          @phone = input[:phone_attributes]
        end
      end
    end
  end
end
