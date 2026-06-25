require_relative "boot"

require "rails"
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module TccFrontend
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w[assets tasks])

    # Configurações i18n para Português Brasil
    config.i18n.default_locale = :"pt-BR"
    config.time_zone = "Brasilia"
  end
end
