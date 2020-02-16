# frozen_string_literal: true

module V1
  module Products
    class IndexQuery < ApplicationQuery
      def call
        base_relation.yield_self(&method(:paginate))
      end

      private

      def paginate(relation)
        relation.order(:created_at).paginate(params)
      end
    end
  end
end
