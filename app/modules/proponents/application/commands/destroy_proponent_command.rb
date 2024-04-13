# frozen_string_literal: true

module Proponents
  module Application
    module Commands
      class DestroyProponentCommand
        attr_reader :id

        def initialize(input)
          @id = input[:id]
        end
      end
    end
  end
end
