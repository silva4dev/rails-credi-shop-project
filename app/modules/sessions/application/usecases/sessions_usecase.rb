# frozen_string_literal: true

require_relative '../../domain/usecases/sessions_usecase_if'
require_relative '../../domain/models/user'
require_relative '../../infrastructure/repositories/sessions_repository'

module Sessions
  module Application
    module Usecases
      class SessionsUsecase < Domain::Usecases::SessionsUsecaseIF
        def initialize(repositories = {})
          super()
          @session_repository = repositories.fetch(:session) do
            Sessions::Infrastructure::Repositories::SessionsRepository.new
          end
        end

        def create_user(input)
          user = Domain::Models::User.new(
            {
              email: input.email,
              password: input.password,
              password_confirmation: input.password_confirmation
            }
          )
          @session_repository.create_user(user)
        end

        def authenticate_user(input)
          user = @session_repository.find_by_email(input)
          return nil if user.blank?

          user.authenticate(input.password)
        end
      end
    end
  end
end
