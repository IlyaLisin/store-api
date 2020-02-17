# frozen_string_literal: true

module Validatable
  extend ActiveSupport::Concern

  WRONG_TYPE = 'wrong type'
  RELATIONSHIPS = 'relationships'

  included do
    validate :check_type, :check_relationships
  end

  private

  def validate_base(params)
    validate_data(params, :base, [Hash])
    raise Model::ValidationError.new(errors, 400) unless errors.empty?

    validate_data(params.dig('data'), :data, [Hash, Array])
    raise Model::ValidationError.new(errors, 400) unless errors.empty?
  end

  def validate_internal(params)
    validate_data(params.dig('data', 'type'), :type, [String])
    validate_data(params.dig('data', 'attributes'), :attributes, [Hash]) unless without_attributes?
    validate_relationships(params)

    raise Model::ValidationError.new(errors, 400) unless errors.empty?
  end

  def validate_data(params, pointer, classes)
    return errors.add(pointer, 'required') unless params

    return if classes.map { |k| params&.is_a?(k) }.include?(true)

    errors.add(pointer, WRONG_TYPE)
  end

  def validate_relationships(params)
    return if params.dig('data')&.key?(RELATIONSHIPS).blank?

    return errors.add(:relationships, WRONG_TYPE) unless
        params.dig('data', RELATIONSHIPS)&.is_a?(Hash)

    validate_relationships_struct(params.dig('data', RELATIONSHIPS))
  end

  def validate_relationships_struct(params)
    params.each do |k, v|
      if v.is_a?(Hash)
        validate_data(v, :"#{RELATIONSHIPS}.#{k}.data", [Hash])
      else
        errors.add(:"#{RELATIONSHIPS}.#{k}", WRONG_TYPE)
      end
    end
  end

  def check_type
    errors.add :type, 'invalid type' if
        @type != self.class::TYPE
  end

  def check_relationships
    relationships.each do |k, v|
      if v.is_a?(Array)
        check_relationships_array(k, v)
      else
        check_relationships_data(k, v)
      end
    end
  end

  def check_relationships_array(key, value)
    value.map { |data| check_relationships_data(key, data) }
  end

  def check_relationships_data(key, data)
    return if data.valid?

    data.errors.messages.each do |k, v|
      v.each do |message|
        errors.add(:"#{RELATIONSHIPS}.#{key}.#{k}", message)
      end
    end
  end

  def raise_validation_error
    raise(Model::ValidationError, errors)
  end
end
