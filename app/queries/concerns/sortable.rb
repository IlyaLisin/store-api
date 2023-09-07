# frozen_string_literal: true

module Sortable
  extend ActiveSupport::Concern

  private

  def sort_by_params(relation, default = nil)
    return default_sort(relation, default) if default.present? && sort_params.blank?

    sort_query = get_sort_query(sort_params, relation.table_name)

    return relation if sort_query.empty?

    relation.order(Arel.sql(sort_query))
  end

  def sort_array_by_params(relation, default)
    return relation.sort_by { |r| r.send(default) } if sort_params.blank?

    sort_params.each do |p|
      relation = relation.sort_by { |r| r.send(p[0] == '-' ? p[1..] : p) }

      relation.reverse! if p[0] == '-'
    end

    relation
  end

  def get_sort_query(params, table_name = nil)
    sort_by = []

    sort_nulls = sort_nulls_param.blank? ? '' : "NULLS #{sort_nulls_param.first}"

    params.each do |p|
      field = p[0] == '-' ? p[1..] : p
      sort = p[0] == '-' ? 'desc' : 'asc'

      sort_by << if table_name.present?
                   "#{table_name}.#{field} #{sort} #{sort_nulls}"
                 else
                   "#{field} #{sort} #{sort_nulls}"
                 end
    end

    sort_by.join(',')
  end

  def default_sort(relation, params)
    relation.order(Arel.sql(get_sort_query([params], relation.table_name)))
  end

  def sort_params
    params[:sort]&.split(',').to_a & allowed_sort
  end

  def sort_nulls_param
    params[:sort_nulls]&.split & %w[first last]
  end
end
