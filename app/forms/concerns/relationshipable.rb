# frozen_string_literal: true

module Relationshipable
  extend ActiveSupport::Concern

  def relationships
    self.class::RELATIONSHIPS.each_with_object({}) do |(k, _v), h|
      h[k] = send(k.to_sym) if @received_relationships.include?(k)
      h
    end
  end

  private

  def write_relationships(relationships)
    @received_relationships = relationships.keys

    relationships.slice(*self.class::RELATIONSHIPS.keys).each do |k, v|
      instance_variable_set "@#{k}", init_relationship(k, v.dig('data'))
    end
  end

  def init_relationship(key, data)
    if data.is_a?(Array)
      data.map { |val| self.class::RELATIONSHIPS[key].new('data' => val) }
    else
      self.class::RELATIONSHIPS[key].new('data' => data)
    end
  end
end
