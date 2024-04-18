# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Proponents::Infrastructure::Workers::UpdateSalaryWorker, type: :worker do
  Sidekiq::Testing.fake!

  describe '#perform' do
    let(:proponent_id) { 123 }
    let(:initial_salary) { 4000.0 }
    let(:new_salary) { 5000.0 }

    it 'updates proponent salary correctly' do
      proponent = Proponents::Infrastructure::Models::Proponent.create(
        id: proponent_id,
        name: 'Jane Smith',
        cpf: '987.654.321-00',
        date_of_birth: Date.new(1990, 3, 15),
        salary: initial_salary
      )
      described_class.new.perform(proponent_id, new_salary)
      proponent.reload
      expect(proponent.salary.to_f).to eq(new_salary)
    end
  end
end
