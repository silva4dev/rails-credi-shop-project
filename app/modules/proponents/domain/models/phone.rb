# frozen_string_literal: true

module Proponents
  module Domain
    module Models
      class Phone
        attr_reader :number, :type

        def initialize(props)
          @number = props[:number]
          @type = props[:type]
        end
      end
    end
  end
end
