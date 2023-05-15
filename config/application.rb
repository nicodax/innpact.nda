require_relative 'boot'

# require 'iconv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Innpact
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    #

    config.i18n.default_locale = :en
    config.middleware.use Rack::MethodOverride

    config.x.disable_rails_autorun_test_db_task = ENV.fetch("DISABLE_RAILS_AUTORUN_TEST_DB_TASK", 0).to_i == 1

    config.active_job.queue_adapter = :async # For async mailer.deliver_later
  end
end
