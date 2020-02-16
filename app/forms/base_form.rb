# frozen_string_literal: true

class BaseForm
  include ActiveModel::Validations
  include Attributable
  include Relationshipable
  include Validatable

  ATTRIBUTES = [].freeze
  RELATIONSHIPS = {}.freeze

  attr_reader :id, :without_attributes

  def initialize(args)
    validate_base(args)
    validate_internal(args)

    @id = args.dig('data', 'id')

    fetch_attrs(args)
    write_attrs(args.dig('data', 'attributes')) unless without_attributes?

    return unless args.dig('data', 'relationships').present?

    write_relationships(args.dig('data', 'relationships'))
  end
end
