# frozen_string_literal: true

Rails.application.config.session_store(
  :redis_session_store,
  key: "_store_#{Rails.env}_session",
  serializer: :json,
  httponly: true,
  redis: {
    db: Rails.application.config.redis_session['db'],
    expire_after: Rails.application.config.redis_session['expire_after'].to_i,
    key_prefix: Rails.application.config.redis_session['prefix'],
    host: Rails.application.config.redis_session['host'],
    port: Rails.application.config.redis_session['port']
  }
)
