# frozen_string_literal: true

require_relative 'application_controller'
require_relative '../usecases/proponents_usecase'
require_relative '../../infrastructure/models/proponent'
require_relative '../commands/create_proponent_command'
require_relative '../commands/destroy_proponent_command'
require_relative '../commands/update_proponent_command'

module Proponents
  module Application
    module Controllers
      class ProponentsController < ApplicationController
        before_action :require_user_logged_in!, except: %i[calculate_inss_discount]

        def index
          proponents_usecase = Usecases::ProponentsUsecase.new
          @proponents = proponents_usecase.find_all_proponents
          @proponents_by_salary_range = proponents_usecase.filter_proponents_by_salary_range({ params:, proponents: @proponents })
          respond_to { |format| format.html { render 'proponents/index' } }
        end

        def new
          @proponent = Infrastructure::Models::Proponent.new
          @proponent.build_address
          @proponent.build_phone
          respond_to { |format| format.html { render 'proponents/new' } }
        end

        def edit
          @proponent = Infrastructure::Models::Proponent.find(params[:id])
          @proponent.build_address unless @proponent.address
          @proponent.build_phone unless @proponent.phone
          respond_to { |format| format.html { render 'proponents/edit' } }
        end

        def create
          command = Commands::CreateProponentCommand.new(proponent_params)
          @proponent = Usecases::ProponentsUsecase.new.create_proponent(command)
          respond_to do |format|
            if @proponent.valid?
              format.html do
                redirect_to proponents_url, flash: { success: 'Registro cadastrado com sucesso.' }
              end
            else
              flash.now[:error] = 'Erro ao criar o proponente. Verifique os campos e tente novamente.'
              format.html { render 'proponents/new', status: :unprocessable_entity }
            end
          end
        end

        def update
          command = Commands::UpdateProponentCommand.new({ id: params[:id], **proponent_params }.transform_keys(&:to_sym))
          @proponent = Usecases::ProponentsUsecase.new.update_proponent(command)
          respond_to do |format|
            if @proponent.valid?
              format.html do
                redirect_to proponents_url, flash: { success: 'Registro atualizado com sucesso.' }
              end
            else
              flash.now[:error] = 'Erro ao atualizar o proponente. Verifique os campos e tente novamente.'
              format.html { render 'proponents/edit', status: :unprocessable_entity }
            end
          end
        end

        def destroy
          command = Commands::DestroyProponentCommand.new({ id: params[:id] })
          @proponent = Usecases::ProponentsUsecase.new.destroy_proponent(command)
          respond_to do |format|
            if @proponent.present?
              format.html do
                redirect_to proponents_url, flash: { success: 'Registro deletado com sucesso.' }
              end
            else
              format.html do
                redirect_to proponents_url, flash: { error: 'Erro ao deletar o registro.' }
              end
            end
          end
        end

        def calculate_inss_discount
          inss_discount = Usecases::ProponentsUsecase.new.calculate_inss_discount({ salary: params[:salary].to_f })
          render json: { inssDiscount: inss_discount }
        end

        private

        def proponent_params
          params.require(:proponent).permit(
            :name,
            :cpf,
            :date_of_birth,
            :salary,
            phone_attributes: %i[number phone_type],
            address_attributes: %i[street number district city uf zipcode]
          )
        end
      end
    end
  end
end
