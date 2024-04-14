# frozen_string_literal: true

require_relative 'application_record'

module Proponents
  module Infrastructure
    module Models
      class Address < ApplicationRecord
        self.table_name = 'addresses'

        belongs_to :proponent

        validates :street, :number, :district, :city, :uf, :zipcode, presence: true
        validates :zipcode, format: { with: /\A\d{5}-\d{3}\z/ }

        def self.model_name
          ActiveModel::Name.new(self, nil, 'address')
        end
      end
    end
  end
end
