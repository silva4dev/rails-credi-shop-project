# frozen_string_literal: true

module Proponents
  module Domain
    module ValueObjects
      class Address
        attr_reader :street, :number, :district, :city, :uf, :zipcode

        def initialize(input)
          @street = input[:street]
          @number = input[:number]
          @district = input[:district]
          @city = input[:city]
          @uf = input[:uf]
          @zipcode = input[:zipcode]
        end
      end
    end
  end
end
