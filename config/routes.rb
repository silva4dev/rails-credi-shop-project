# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root to: redirect("/sign_in")

  scope module: :proponents do
    scope module: :application do
      scope module: :controllers do
        resources :proponents do
          collection do
            get 'calculate_inss_discount'
          end
        end
      end
    end
  end

  scope module: :sessions do
    scope module: :application do
      scope module: :controllers do
        get 'sign_up', to: 'registrations#new'
        post 'sign_up', to: 'registrations#create'
        get 'sign_in', to: 'logins#new'
        post 'sign_in', to: 'logins#create'
        delete 'logout', to: 'logins#destroy'
      end
    end
  end
end
