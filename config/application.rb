# frozen_string_literal: true

require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module RailsCreditShopCleanProject
  class Application < Rails::Application
    config.load_defaults 7.1
    config.time_zone = 'Brasilia'
    config.i18n.default_locale = 'pt-BR'
    config.autoload_paths += Dir[Rails.root.join("app/modules")]
    config.autoload_lib(ignore: %w[assets tasks])
    config.generators.system_tests = nil
  end
end
