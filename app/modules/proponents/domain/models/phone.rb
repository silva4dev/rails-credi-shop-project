# frozen_string_literal: true

require 'securerandom'

module Proponents
  module Domain
    module Models
      class Phone
        attr_reader :id, :number, :phone_type

        def initialize(input)
          @id = input[:id] || SecureRandom.uuid
          @number = input[:number]
          @phone_type = input[:phone_type]
        end
      end
    end
  end
end
