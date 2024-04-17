# frozen_string_literal: true

module Sessions
  module Domain
    module Usecases
      class SessionsUsecaseIF
        def create_user(input)
          raise NotImplementedError
        end

        def authenticate_user(input)
          raise NotImplementedError
        end
      end
    end
  end
end
