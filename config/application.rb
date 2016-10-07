require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DfaquiAdmin
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = 'Brasilia'
    config.i18n.default_locale = :'pt-BR'

    # config.action_controller.include_all_helpers = false

    config.generators do |g|
      g.test_framework :rspec

      g.assets false
      g.helper false
      g.view_specs false
    end
  end
end
