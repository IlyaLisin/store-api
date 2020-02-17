# frozen_string_literal: true

module Helpers
  def default_headers
    { 'Accept' => 'application/vnd.api+json', 'Content-Type' => 'application/vnd.api+json' }
  end

  def json
    JSON.parse response.body
  end
end
