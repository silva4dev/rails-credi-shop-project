# frozen_string_literal: true

require_relative 'application_record'

module Sessions
  module Infrastructure
    module Models
      class Current < ActiveSupport::CurrentAttributes
        attribute :user
      end
    end
  end
end
