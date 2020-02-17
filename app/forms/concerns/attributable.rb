# frozen_string_literal: true

module Attributable
  extend ActiveSupport::Concern

  def attributes
    self.class::ATTRIBUTES.inject({}) { |r, s| @received_attributes.include?(s) ? r.merge!(s => send(s.to_sym)) : r }
  end

  def without_attributes?
    @without_attributes.present?
  end

  private

  def fetch_attrs(args)
    @received_attributes = args.dig('data', 'attributes')&.keys
    @received_relationships = []
    @type = args.dig('data', 'type')
  end

  def write_attrs(attrs)
    attrs.slice(*self.class::ATTRIBUTES).each do |k, v|
      instance_variable_set "@#{k}", v
    end
  end
end
