# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect("/proponents")
  scope module: :proponents do
    scope module: :application do
      scope module: :controllers do
        resources :proponents do
          get 'calculate_inss_discount', on: :collection
        end
      end
    end
  end
end
