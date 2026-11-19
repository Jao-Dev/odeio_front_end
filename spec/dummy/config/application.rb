require_relative "boot"

require "rails"
require "action_controller/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module Dummy
  class Application < Rails::Application
    config.root = File.expand_path("..", __dir__)
    config.load_defaults 8.1
    config.eager_load = false
    config.secret_key_base = "chave-do-dummy"
    config.action_dispatch.show_exceptions = false
    config.hosts.clear
  end
end
