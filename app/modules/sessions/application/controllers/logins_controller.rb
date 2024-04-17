# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../usecases/sessions_usecase'
require_relative '../../infrastructure/models/user'

module Sessions
  module Application
    module Controllers
      class LoginsController < ApplicationController
        def new
          @user = Infrastructure::Models::User.new
          respond_to { |format| format.html { render 'sessions/login/new' } }
        end

        def create
          @user = Infrastructure::Models::User.new(user_params)
          user = Usecases::SessionsUsecase.new.authenticate_user(@user)
          respond_to do |format|
            if user.present?
              session[:user_id] = user.id
              format.html { redirect_to proponents_url, flash: { success: 'Logado com sucesso.' } }
            else
              flash.now[:error] = 'Email ou senha inválidos. Tente novamente.'
              format.html { render 'sessions/login/new', status: :unprocessable_entity }
            end
          end
        end

        def destroy
          session[:user_id] = nil
          redirect_to root_path, flash: { success: 'Logout efetuado com sucesso.' }
        end

        private

        def user_params
          params.require(:user).permit(:email, :password)
        end
      end
    end
  end
end
