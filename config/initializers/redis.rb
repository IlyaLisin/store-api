# frozen_string_literal: true

require 'redis'

Redis.define_singleton_method(:current) do
  Redis.new(Rails.application.config.redis)
end

Redis.define_singleton_method(:session) do
  Redis.new(Rails.application.config.redis_session.slice(:host, :port, :db))
end
