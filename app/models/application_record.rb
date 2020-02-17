# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.without_pagination
    except(:limit, :offset)
  end
end
