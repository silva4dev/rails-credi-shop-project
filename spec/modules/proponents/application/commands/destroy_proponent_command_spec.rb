# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponents::Application::Commands::DestroyProponentCommand, type: :command do
  describe '#initialize' do
    it 'initializes with the correct id' do
      input = { id: 1 }
      command = described_class.new(input)

      expect(command.id).to eq(1)
    end
  end
end
