require_relative 'boot'
require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
Bundler.require(*Rails.groups)
module Snappy
  class Application < Rails::Application
    ENV["SECRET_KEY_BASE"] = "secretkey"

    config.action_cable.disable_request_forgery_protection = true
    config.action_controller.action_on_unpermitted_parameters = :raise
    config.action_controller.allow_forgery_protection = false
    config.action_controller.perform_caching = false
    config.action_dispatch.show_exceptions = false
    config.action_mailer.default_url_options = { host: "www.example.com" }
    config.action_mailer.delivery_method = :test
    config.action_mailer.perform_caching = false
    config.action_view.raise_on_missing_translations = true
    config.active_job.queue_adapter = :delayed_job
    config.active_support.deprecation = :stderr
    config.assets.quiet = true
    config.assets.raise_runtime_errors = true
    config.cache_classes = true
    config.consider_all_requests_local = true
    config.eager_load = false
    config.public_file_server.enabled = true
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=3600",
    }
  end
end
