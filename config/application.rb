require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Replace the randomnumbergeneratedbyngrok with the address assigned by the
    # free version of ngrok. If you pay for a custom domain then put it here.
    config.hosts << "randomnumbergeneratedbyngrok.ngrok.io"
  end
end
