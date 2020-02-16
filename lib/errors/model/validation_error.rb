# frozen_string_literal: true

module Model
  # Класс для вызова ошибки валидации
  # @param errors [ActiveModel::Errors] ошибка валидации
  # @param http [Integer] http-код ошибки
  class ValidationError < MultiError
    def initialize(errors, http = 422)
      super(hsh_error(errors.to_hash(:full_messages), nil), http)
    end

    private

    def hsh_error(obj, top_level_attr)
      if obj.is_a? Array
        return obj.map { |elem| SingleValidationError.new(elem, 422, pointer: "/data/attributes#{top_level_attr}") }
      end

      obj.map do |attr, value|
        hsh_error(value, "#{top_level_attr}/#{attr}")
      end.inject(&:+)
    end
  end
end
