# frozen_string_literal: true

require_relative 'application_record'

module Proponents
  module Infrastructure
    module Models
      class Proponent < ApplicationRecord
        self.table_name = 'proponents'

        has_one :address, dependent: :destroy
        has_one :phone, dependent: :destroy

        accepts_nested_attributes_for :address, :phone

        validates :name, :cpf, :date_of_birth, :salary, presence: true
        validates :cpf, uniqueness: { case_sensitive: false }
        validates :cpf, cpf: true, format: { with: /\A\d{3}\.\d{3}\.\d{3}-\d{2}\z/ }
        validate :date_of_birth_not_in_future

        def date_of_birth_not_in_future
          return unless date_of_birth.present? && date_of_birth > Date.current

          errors.add(:date_of_birth, I18n.t('errors.messages.date_of_birth_not_in_future'))
        end

        def self.model_name
          ActiveModel::Name.new(self, nil, 'proponent')
        end
      end
    end
  end
end
