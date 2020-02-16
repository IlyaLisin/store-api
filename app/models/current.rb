# frozen_string_literal: true

# Потокоизолированные атрибуты текущего запроса
# Используется для упрощения получения текущего пользователя
# see more: https://api.rubyonrails.org/classes/ActiveSupport/CurrentAttributes.html
class Current < ActiveSupport::CurrentAttributes
  attribute :user, :session
end
