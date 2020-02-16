# frozen_string_literal: true

module Paginable
  extend ActiveSupport::Concern

  MAX_PAGE_SIZE = 50
  MIN_PAGE_SIZE = 1
  DEFAULT_PAGE_SIZE = 10
  MIN_PAGE_NUMBER = 0

  included do
    scope :paginate, (lambda do |params|
      page_number = 0
      page_size = DEFAULT_PAGE_SIZE

      if params[:page]
        if params[:page][:number]
          page_number = params[:page][:number].to_i
          raise InvalidParamsError, "wrong page number #{page_number}" if
            page_number < MIN_PAGE_NUMBER
        end

        if params[:page][:size]
          page_size = params[:page][:size].to_i
          if page_size > MAX_PAGE_SIZE || page_size < MIN_PAGE_SIZE
            raise InvalidParamsError, "wrong_page_size #{page_size}"
          end
        end
      end

      offset(page_number * page_size).limit(page_size)
    end)
  end
end
