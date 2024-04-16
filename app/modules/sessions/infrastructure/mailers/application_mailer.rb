# frozen_string_literal: true

module Sessions
  module Infrastructure
    module Mailers
      class ApplicationMailer < ActionMailer::Base
        default from: "from@example.com"
        layout "mailer"
      end
    end
  end
end
