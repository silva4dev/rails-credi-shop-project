# frozen_string_literal: true

require 'securerandom'

module Proponents
  module Domain
    module Models
      class Proponent
        attr_reader :id, :name, :cpf, :date_of_birth, :salary, :phone, :address

        def initialize(input)
          @id = input[:id] || SecureRandom.uuid
          @name = input[:name]
          @cpf = input[:cpf]
          @date_of_birth = input[:date_of_birth]
          @salary = input[:salary]
          @phone = input[:phone]
          @address = input[:address]
        end
      end
    end
  end
end
