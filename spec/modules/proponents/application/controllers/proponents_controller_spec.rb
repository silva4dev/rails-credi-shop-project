# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponents::Application::Controllers::ProponentsController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template('proponents/index')
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template('proponents/new')
    end
  end

  describe 'GET #edit' do
    let(:proponent) do
      Proponents::Infrastructure::Models::Proponent.create(
        id: 1,
        name: 'John Doe',
        cpf: '940.431.980-51',
        date_of_birth: Date.new(1980, 1, 1),
        salary: 5000.0,
        address_attributes: {
          street: '123 Main St',
          number: '1A',
          district: 'Downtown',
          city: 'Exampleville',
          uf: 'EX',
          zipcode: '12345-678'
        },
        phone_attributes: {
          number: '+55 (19) 99337-4443',
          phone_type: 'personal'
        }
      )
    end

    it 'returns http success' do
      get :edit, params: { id: proponent.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template('proponents/edit')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:proponent_params) do
        {
          proponent: {
            name: 'Jane Doe',
            cpf: '755.520.170-48',
            date_of_birth: Date.new(1990, 5, 15),
            salary: 6000.0,
            phone_attributes: { number: '+55 (19) 98888-8888', phone_type: 'personal' },
            address_attributes: {
              street: '456 Elm St',
              number: '2B',
              district: 'Uptown',
              city: 'Exampletown',
              uf: 'ET',
              zipcode: '54321-987'
            }
          }
        }
      end

      it 'creates a new proponent' do
        expect do
          post :create, params: proponent_params
        end.to change(Proponents::Infrastructure::Models::Proponent, :count).by(1)

        expect(response).to redirect_to(proponents_url)
        expect(flash[:success]).to eq('Registro cadastrado com sucesso.')
      end
    end
  end

  describe 'PUT #update' do
    let!(:proponent) do
      Proponents::Infrastructure::Models::Proponent.create(
        id: 1,
        name: 'John Doe',
        cpf: '097.963.310-98',
        date_of_birth: Date.new(1980, 1, 1),
        salary: 5000.0,
        address_attributes: {
          street: '123 Main St',
          number: '1A',
          district: 'Downtown',
          city: 'Exampleville',
          uf: 'EX',
          zipcode: '12345-678'
        },
        phone_attributes: {
          number: '+55 (19) 99337-4443',
          phone_type: 'personal'
        }
      )
    end

    context 'with valid parameters' do
      let(:updated_params) do
        {
          id: proponent.id,
          proponent: {
            name: 'Updated Name',
            cpf: '253.401.480-33',
            date_of_birth: Date.new(1990, 5, 15),
            salary: 6000.0,
            phone_attributes: { number: '+55 (19) 98888-8888', phone_type: 'personal' },
            address_attributes: {
              street: '456 Elm St',
              number: '2B',
              district: 'Uptown',
              city: 'Exampletown',
              uf: 'ET',
              zipcode: '54321-987'
            }
          }
        }
      end

      it 'updates the proponent' do
        put :update, params: updated_params
        expect(response).to redirect_to(proponents_url)
        expect(flash[:success]).to eq('Registro atualizado com sucesso.')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:proponent) do
      Proponents::Infrastructure::Models::Proponent.create(
        id: 1,
        name: 'John Doe',
        cpf: '633.375.370-06',
        date_of_birth: Date.new(1980, 1, 1),
        salary: 5000.0,
        address_attributes: {
          street: '123 Main St',
          number: '1A',
          district: 'Downtown',
          city: 'Exampleville',
          uf: 'EX',
          zipcode: '12345-678'
        },
        phone_attributes: {
          number: '+55 (19) 99337-4443',
          phone_type: 'personal'
        }
      )
    end

    it 'destroys the proponent' do
      expect do
        delete :destroy, params: { id: proponent.id }
      end.to change(Proponents::Infrastructure::Models::Proponent, :count).by(-1)

      expect(response).to redirect_to(proponents_url)
      expect(flash[:success]).to eq('Registro deletado com sucesso.')
    end
  end
end
