# frozen_string_literal: true

class CreateFullTextIndexOnProducts < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pg_trgm'

    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE INDEX IF NOT EXISTS trgm_idx_on_products_name ON products USING GIN (name public.gin_trgm_ops);
        SQL
      end

      dir.down do
        execute <<-SQL
          DROP INDEX trgm_idx_on_products_name
        SQL
      end
    end
  end
end
