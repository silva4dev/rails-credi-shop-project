# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../usecases/proponents_usecase'

module Proponents
  module Application
    module Controllers
      class ProponentsController < ApplicationController
        def index
          input = { page: params[:page] }
          @proponents = Usecases::ProponentsUsecase.new.find_all_proponents_by_page(input)
          respond_to do |format|
            format.html do
              render 'proponents/index'
            end
          end
        end

        def new
          render 'proponents/new'
        end
      end
    end
  end
end
