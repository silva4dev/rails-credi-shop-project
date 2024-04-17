# frozen_string_literal: true

module Sessions
  module Application
    module Commands
      class CreateUserCommand
        attr_reader :email, :password, :password_confirmation

        def initialize(input)
          @email = input[:email]
          @password = input[:password]
          @password_confirmation = input[:password_confirmation]
        end
      end
    end
  end
end
