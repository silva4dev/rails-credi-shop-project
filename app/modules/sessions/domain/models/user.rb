# frozen_string_literal: true

require 'securerandom'

module Sessions
  module Domain
    module Models
      class User
        attr_reader :id, :email, :password, :password_confirmation

        def initialize(input)
          @id = input[:id] || SecureRandom.uuid
          @email = input[:email]
          @password = input[:password]
          @password_confirmation = input[:password_confirmation]
        end
      end
    end
  end
end
