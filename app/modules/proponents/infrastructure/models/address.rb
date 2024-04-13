# frozen_string_literal: true

require_relative 'application_record'

module Proponents
  module Infrastructure
    module Models
      class Address < ApplicationRecord
        belongs_to :proponent

        validates :street, :number, :district, :city, :state, :cep, presence: true
        validates :cep, format: { with: /\A\d{5}-\d{3}\z/ }
      end
    end
  end
end
