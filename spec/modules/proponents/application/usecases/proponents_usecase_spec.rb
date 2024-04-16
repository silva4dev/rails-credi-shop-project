# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponents::Application::Usecases::ProponentsUsecase, type: :usecases do
  let(:proponents_repository) { instance_double(Proponents::Infrastructure::Repositories::ProponentsRepository) }
  let(:usecase) { described_class.new(proponent: proponents_repository) }

  describe '#find_all_proponents' do
    it 'calls ProponentsQuery.find_all_proponents' do
      proponent_list = [
        Proponents::Domain::Models::Proponent.new(name: 'John Doe', cpf: '123.456.789-00', date_of_birth: Date.new(1980, 1, 1), salary: 5000.0),
        Proponents::Domain::Models::Proponent.new(name: 'Jane Smith', cpf: '987.654.321-00', date_of_birth: Date.new(1975, 5, 15), salary: 6000.0),
        Proponents::Domain::Models::Proponent.new(name: 'Bob Johnson', cpf: '456.789.123-00', date_of_birth: Date.new(1990, 8, 20), salary: 5500.0)
      ]
      allow(Proponents::Infrastructure::Queries::ProponentsQuery).to receive(:find_all_proponents).and_return(proponent_list)
      output = usecase.find_all_proponents
      expect(output.count).to eq(3)
    end
  end
end
