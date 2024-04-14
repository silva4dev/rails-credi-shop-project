# frozen_string_literal: true

require_relative 'application_record'

module Proponents
  module Infrastructure
    module Models
      class Phone < ApplicationRecord
        self.table_name = 'phones'

        enum phone_type: { personal: 0, reference: 1 }

        belongs_to :proponent

        validates :number, :phone_type, presence: true
        validates :number, format: { with: /\A\+55\s\(\d{2}\)\s\d{5}-\d{4}\z/ }

        def self.model_name
          ActiveModel::Name.new(self, nil, 'phone')
        end
      end
    end
  end
end
