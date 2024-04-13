# frozen_string_literal: true

module Proponents
  module Domain
    module ValueObjects
      class Address
        attr_reader :street, :number, :district, :city, :state, :cep

        def initialize(props)
          @street = props[:street]
          @number = props[:number]
          @district = props[:district]
          @city = props[:city]
          @state = props[:state]
          @cep = props[:cep]
        end
      end
    end
  end
end
