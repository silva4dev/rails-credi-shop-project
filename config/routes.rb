# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect("/sign_in")

  scope module: :proponents do
    scope module: :application do
      scope module: :controllers do
        resources :proponents
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
