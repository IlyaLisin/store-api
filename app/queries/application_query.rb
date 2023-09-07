# frozen_string_literal: true

class ApplicationQuery
  include Sortable
  include Paginable

  delegate :params, to: :request

  def self.call(relation, request)
    new(relation, request).call
  end

  def initialize(relation, request)
    @base_relation = relation
    @request = request
  end

  private

  attr_reader :base_relation, :request
end
