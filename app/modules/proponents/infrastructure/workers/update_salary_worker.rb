# frozen_string_literal: true

require 'sidekiq'
require_relative '../repositories/proponents_repository'

module Proponents
  module Infrastructure
    module Workers
      class UpdateSalaryWorker
        include Sidekiq::Worker
        sidekiq_options queue: 'default', retry: 3

        def perform(proponent_id, salary)
          Infrastructure::Repositories::ProponentsRepository.new.update_by_salary({ id: proponent_id.to_i, salary: salary.to_f })
        end
      end
    end
  end
end
