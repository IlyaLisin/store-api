# frozen_string_literal: true

module V1
  module Products
    class IndexQuery < ApplicationQuery
      def call
        base_relation
          .yield_self(&method(:filter_by_name))
          .yield_self(&method(:filter_by_price))
          .yield_self { |relation| sort_by_params(relation, '-created_at') }
          .yield_self(&method(:paginate))
      end

      private

      def allowed_sort
        %w[name -name
           price -price
           created_at -created_at]
      end

      def filter_by_name(relation)
        name = params.dig('filter', 'name')

        name.nil? ? relation : relation.search_by_name(name)
      end

      def filter_by_price(relation)
        price_from = params.dig('filter', 'price_from')
        price_to = params.dig('filter', 'price_to')

        relation = relation.where('price >= ?', price_from.to_i) if price_from.present?
        relation = relation.where('price <= ?', price_to.to_i) if price_to.present?

        relation
      end
    end
  end
end
