# frozen_string_literal: true

module Proponents
  module Domain
    module Models
      class Proponent
        attr_reader :name, :cpf, :date_of_birth, :salary, :phones, address

        def initialize(props)
          @name = props[:name]
          @cpf = props[:cpf]
          @date_of_birth = props[:date_of_birth]
          @salary = props[:salary]
          @phones = props[:phones]
          @address = props[:address]
        end
      end
    end
  end
end
