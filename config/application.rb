require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

require 'action_cable'

Bundler.require(*Rails.groups)

module Askme
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/app/channels)

    config.generators do |g|
      g.test_framework  nil #to skip test framework
    end
    config.time_zone = 'Moscow'

    config.i18n.default_locale = :en
    config.i18n.locale = :ru

    config.i18n.fallbacks = [:en]
  end
end
