require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Recipes
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.exceptions_app = self.routes # static errors page
    
    config.time_zone = "Kyiv" # 'Paris', 'Moscow' 
    config.active_record.default_timezone = :local
    config.i18n.available_locales = %i(en ru)
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true
    
    config.active_record.belongs_to_required_by_default = true
    config.autoload_paths << "#{Rails.root}/lib/clients"

    config.generators do |g|
      g.helper      false
      g.javascripts false
      g.stylesheets false
      g.decorator   false

      g.template_engine :slim
      g.fixture_replacement :factory_bot, dir: "spec/factories"

      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
    end
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
