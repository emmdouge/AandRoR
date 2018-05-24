require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module A2rBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # config.assets.enabled = true
    # config.assets.prefix = '/client/dist/prod'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.middleware.use ActionDispatch::Flash
    config.middleware.use ActionDispatch::Cookies
    # cookie-based session store is the Rails default after logging in
    # Will store user session (like after logging in using Google) in cookie
    # Press Ctrl+Shift+I while on localhost to Use Dev Tools in chrome
    # Under the application tab and cookies, a session should be there
    config.middleware.use ActionDispatch::Session::CookieStore, :key => '_a2r_key'
  end
end
