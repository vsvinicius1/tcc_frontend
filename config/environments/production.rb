require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.force_ssl = true
  config.log_level = :info
  config.log_tags = [:request_id]
  config.assets.compile = false
end
