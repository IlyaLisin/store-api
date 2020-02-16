# frozen_string_literal: true

require 'redis'

Redis.current = Redis.new(Rails.application.config.redis)

Redis.define_singleton_method(:session) do
  Redis.new(Rails.application.config.redis_session)
end
