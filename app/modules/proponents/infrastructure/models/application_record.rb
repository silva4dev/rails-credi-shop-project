# frozen_string_literal: true

module Proponents
  module Infrastructure
    module Models
      class ApplicationRecord < ActiveRecord::Base
        primary_abstract_class
      end
    end
  end
end
