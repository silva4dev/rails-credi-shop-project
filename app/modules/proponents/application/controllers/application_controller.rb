# frozen_string_literal: true

require_relative '../../../sessions/infrastructure/models/user'
require_relative '../../../sessions/infrastructure/models/current'

module Proponents
  module Application
    module Controllers
      class ApplicationController < ActionController::Base
        layout 'layouts/application'

        before_action :set_current_user

        def set_current_user
          return unless session[:user_id]

          Sessions::Infrastructure::Models::User.find_by(id: session[:user_id])
          Sessions::Infrastructure::Models::Current.user = Sessions::Infrastructure::Models::User.find_by(id: session[:user_id])
        end

        def require_user_logged_in!
          redirect_to sign_in_path, flash: { error: 'Você precisa estar logado para acessar esta tela' } if Sessions::Infrastructure::Models::Current.user.nil?
        end
      end
    end
  end
end
