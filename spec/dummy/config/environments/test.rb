require Rails.root.join("spec/support/active_job")

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = false
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => 'public, max-age=3600'
  }
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :test
  config.active_support.deprecation = :stderr
  config.action_view.raise_on_missing_translations = true
  config.assets.raise_runtime_errors = true
  config.action_mailer.default_url_options = { host: "www.example.com" }
  config.active_job.queue_adapter = :controlled_synchronous
  config.action_cable.disable_request_forgery_protection = true
end
