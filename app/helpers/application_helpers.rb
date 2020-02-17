# frozen_string_literal: true

module ApplicationHelpers
  def build_site_url(options = {})
    args = {
      scheme: Rails.configuration.settings['server_protocol'],
      host: Rails.configuration.settings['server_host'],
      port: Rails.configuration.settings['server_port']
    }.merge(options)
    URI::HTTP.build args
  end
end
