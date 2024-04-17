# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../usecases/sessions_usecase'
require_relative '../commands/create_user_command'

module Sessions
  module Application
    module Controllers
      class RegistrationsController < ApplicationController
        def new
          @user = Infrastructure::Models::User.new
          respond_to { |format| format.html { render 'sessions/registrations/new' } }
        end

        def create
          command = Commands::CreateUserCommand.new(user_params)
          @user = Usecases::SessionsUsecase.new.create_user(command)
          respond_to do |format|
            if @user.valid?
              session[:user_id] = @user.id
              format.html { redirect_to proponents_url, flash: { success: 'Registrado com sucesso.' } }
            else
              flash.now[:error] = 'Email ou senha inválidos. Tente novamente.'
              format.html { render 'sessions/registrations/new', status: :unprocessable_entity }
            end
          end
        end

        private

        def user_params
          params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
      end
    end
  end
end
