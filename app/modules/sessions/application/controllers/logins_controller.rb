# frozen_string_literal: true

require_relative 'application_controller'

module Sessions
  module Application
    module Controllers
      class LoginsController < ApplicationController
        def new
          @user = Infrastructure::Models::User.new
          respond_to { |format| format.html { render 'sessions/login/new' } }
        end

        def create
          @user = Sessions::Infrastructure::Models::User.new(user_params)
          user = Sessions::Infrastructure::Models::User.find_by(email: params[:user][:email])
          respond_to do |format|
            if user.present? && user.authenticate(params[:user][:password])
              session[:user_id] = user.id
              format.html { redirect_to proponents_path, flash: { success: 'Logado com sucesso.' } }
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
