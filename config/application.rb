require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module TedFun
  class Application < Rails::Application
    config.load_defaults 7.0

    # Move the CORS configuration inside the Application class
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:3000'
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          credentials: true
      end
    end

    # config/application.rb or config/environments/development.rb, etc.
Rails.application.config.secret_key_base = 'Rails.application.secret_key_base'
config.filter_parameters += [:password, :auth_token, :other_sensitive_param]


    # Configuration for the application, engines, and railties goes here.
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
