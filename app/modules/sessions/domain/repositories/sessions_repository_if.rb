# frozen_string_literal: true

module Sessions
  module Domain
    module Repositories
      class SessionsRepositoryIF
        def create_user(input)
          raise NotImplementedError
        end

        def find_by_email(input)
          raise NotImplementedError
        end
      end
    end
  end
end
