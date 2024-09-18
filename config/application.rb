require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HclpBe
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    Encoding.default_external = Encoding::UTF_8
    Encoding.default_internal = Encoding::UTF_8

    config.load_defaults 7.0

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:3000'  # El origen de tu frontend

        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          credentials: true # Esto es opcional, se puede omitir si no necesitas enviar cookies o credenciales
      end
    end
    # Desactivar el generador de Mongoid para tareas de migración
    config.generators do |g|
      g.orm :active_record
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
