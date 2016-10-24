require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Proj
  class Application < Rails::Application
    config.active_job.queue_adapter = :sucker_punch

    # TODO(someday): figure out something better for sandstorm origin
    config.action_cable.disable_request_forgery_protection = true

    config.logger = Logger.new(STDOUT)
  end
end
