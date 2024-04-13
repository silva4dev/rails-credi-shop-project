# frozen_string_literal: true

require_relative 'application_job'

module Proponents
  module Infrastructure
    module Jobs
      class UpdateSalariesJob < ApplicationJob
        queue_as :default

        def perform
          proponent_salaries = Proponent.pluck(:id, :salary)
          new_salaries = proponent_salaries.map { |id, salary| [id, salary * 1.05] }
          Proponent.update(new_salaries.to_h)
        end
      end
    end
  end
end
