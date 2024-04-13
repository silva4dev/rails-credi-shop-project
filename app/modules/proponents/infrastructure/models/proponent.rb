# frozen_string_literal: true

require_relative 'application_record'

module Proponents
  module Infrastructure
    module Models
      class Proponent < ApplicationRecord
        has_one :address, dependent: :destroy
        has_many :phones, dependent: :destroy, as: :phoneable

        validates :name, :cpf, :date_of_birth, :salary, presence: true
        validates :cpf, uniqueness: { case_sensitive: false }
        validates :cpf, cpf: true, format: { with: /\A\d{3}\.\d{3}\.\d{3}-\d{2}\z/ }
        validates :date_of_birth, date: { before_or_equal_to: proc { Time.zone.now }, message: :invalid }

        accepts_nested_attributes_for :address
        accepts_nested_attributes_for :phones, allow_destroy: true
      end
    end
  end
end
