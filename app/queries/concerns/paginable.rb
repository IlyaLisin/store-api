# frozen_string_literal: true

module Paginable
  extend ActiveSupport::Concern

  MAX_PAGE_SIZE     = 1000
  MIN_PAGE_SIZE     = 1
  DEFAULT_PAGE_SIZE = 20
  MIN_PAGE_NUMBER   = 1

  # next     - next page number or nil
  # prev     - previous page number or nil
  # page     - the current page number
  # pages    - the number of total pages in the collection (cardinal)
  # last     - the number of the last page in the collection (ordinal)
  # items    - the actual number of items in the current non-empty page
  # count    - collection size
  def paginate(relation, options = {})
    set_pagination_params

    return build_array_pagination(relation) if relation.is_a?(Array)

    if (request.headers && request.headers['X-Countless'].present?) || options[:countless].present?
      return build_countless_pagination(relation, wrap_by_relation: options[:wrap_by_relation])
    end

    build_pagination(relation, wrap_by_relation: options[:wrap_by_relation])
  end

  def set_pagination_params
    @page_size = DEFAULT_PAGE_SIZE
    @page_number = MIN_PAGE_NUMBER

    return unless params[:page].present?

    @page_size = params[:page][:size].to_i if params[:page][:size]
    @page_number = params[:page][:number].to_i if params[:page][:number]

    @page_size = MAX_PAGE_SIZE if @page_size > MAX_PAGE_SIZE
    @page_size = MIN_PAGE_SIZE if @page_size < MIN_PAGE_SIZE
    @page_number = MIN_PAGE_NUMBER if @page_number < MIN_PAGE_NUMBER
  end

  def build_pagination(relation, options = {})
    relation = relation.offset((@page_number - 1) * @page_size).limit(@page_size)

    count = relation.unscope(:order).except(:limit, :offset).size
    pages = last = [(count.to_f / @page_size).ceil, 1].max

    if options[:wrap_by_relation]
      relation = options[:wrap_by_relation].from("(#{relation.to_sql}) #{options[:wrap_by_relation].table.name}")
    end

    {
      data: relation,
      meta: {
        count: count,
        pages: pages,
        last: last,
        items: @page_number == pages && count.positive? ? count - ((pages - 1) * @page_size) : @page_size,
        page: @page_number,
        next: @page_number >= last ? nil : @page_number + 1,
        prev: @page_number <= 1 ? nil : @page_number - 1
      }
    }
  end

  def build_countless_pagination(relation, options = {})
    relation = relation.offset((@page_number - 1) * @page_size).limit(@page_size + 1)
    if options[:wrap_by_relation]
      relation = options[:wrap_by_relation].from("(#{relation.to_sql}) #{options[:wrap_by_relation].table.name}")
    end
    relation = relation.to_a

    items_size = relation.size

    next_page = if items_size >= @page_size + 1
                  relation.pop
                  @page_number + 1
                end

    pages = last = relation.size < items_size ? @page_number + 1 : @page_number

    {
      data: relation,
      meta: {
        count: nil,
        pages: pages,
        last: last,
        items: relation.size <= items_size && !relation.empty? ? relation.size : 0,
        page: @page_number,
        next: next_page,
        prev: @page_number <= 1 ? nil : @page_number - 1
      }
    }
  end

  def build_array_pagination(relation, _options = {})
    count = relation.size
    pages = last = [(count.to_f / @page_size).ceil, 1].max

    {
      data: relation[(@page_number - 1) * @page_size, @page_size] || [],
      meta: {
        count: count,
        pages: pages,
        last: last,
        items: @page_number == pages && count.positive? ? count - ((pages - 1) * @page_size) : @page_size,
        page: @page_number,
        next: @page_number >= last ? nil : @page_number + 1,
        prev: @page_number <= 1 ? nil : @page_number - 1
      }
    }
  end
end
