Sentry.init do |config|
  config.breadcrumbs_logger = [:active_support_logger]
  config.background_worker_threads = 0
  config.enabled_environments = %w(staging uat production)
  config.environment = ENV.fetch("SENTRY_CURRENT_ENV", "missing-env")
  config.send_default_pii = true
  config.traces_sample_rate = 1.0 # set a float between 0.0 and 1.0 to enable performance monitoring
  config.dsn = ENV.fetch("SENTRY_DNS", "missing-dns")
  # you can use the pre-defined job for the async callback
  #
  # config.async = lambda do |event, hint|
  #   Sentry::SendEventJob.perform_later(event, hint)
  # end
end
