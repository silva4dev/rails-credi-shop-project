# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect("/proponents")
  scope module: :proponents do
    scope module: :application do
      scope module: :controllers do
        resources :proponents
      end
    end
  end
end
