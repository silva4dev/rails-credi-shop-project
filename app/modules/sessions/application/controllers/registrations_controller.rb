# frozen_string_literal: true

require_relative 'application_controller'

module Sessions
  module Application
    module Controllers
      class RegistrationsController < ApplicationController
        def new
          @user = Infrastructure::Models::User.new
          respond_to { |format| format.html { render 'sessions/registrations/new' } }
        end

        def create
          @user = Infrastructure::Models::User.new(user_params)
          respond_to do |format|
            if @user.save
              session[:user_id] = @user.id
              format.html { redirect_to root_path, flash: { success: 'Registrado com sucesso.' } }
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
