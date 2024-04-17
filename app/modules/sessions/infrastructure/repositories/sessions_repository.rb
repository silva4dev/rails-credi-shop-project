# frozen_string_literal: true

require_relative '../../domain/repositories/sessions_repository_if'
require_relative '../models/user'

module Sessions
  module Infrastructure
    module Repositories
      class SessionsRepository < Domain::Repositories::SessionsRepositoryIF
        def create_user(input)
          user = Models::User.new(
            email: input.email,
            password: input.password,
            password_confirmation: input.password_confirmation
          )
          user.save
          user
        end

        def find_by_email(input)
          Models::User.find_by(email: input.email)
        end
      end
    end
  end
end
