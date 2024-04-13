# frozen_string_literal: true

require_relative 'application_record'

module Proponents
  module Infrastructure
    module Models
      class Phone < ApplicationRecord
        enum type: { personal: 0, reference: 1 }

        belongs_to :proponent

        validates :number, presence: true
        validates :number, format: { with: /\A\+55\s\(\d{2}\)\s\d{5}-\d{4}\z/ }

        validates :type, inclusion: { in: %w[personal reference] }
      end
    end
  end
end
