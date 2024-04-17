# frozen_string_literal: true

require_relative 'application_record'

module Sessions
  module Infrastructure
    module Models
      class User < ApplicationRecord
        self.table_name = 'users'

        has_secure_password
        validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }

        def self.model_name
          ActiveModel::Name.new(self, nil, 'user')
        end
      end
    end
  end
end
