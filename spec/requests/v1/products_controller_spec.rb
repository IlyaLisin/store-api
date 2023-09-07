# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ProductsController, type: :request do
  describe 'GET #index' do
    let(:products) do
      build_list(:product, 6) do |record, i|
        record.created_at = i.hours.ago
        record.price = i
        record.save!
      end
    end
    let(:default_request) do
      get '/v1/products'
    end

    before do
      products
    end

    it 'respond with 200' do
      default_request
      expect(response.status).to eq(200)
    end

    it 'return products list with default sort by created_at desc' do
      default_request
      expect(json['data'].map { |d| d['id'] }).to eq(products.map(&:id))
    end

    context 'with filter[name]' do
      let(:serached_product) { create(:product, name: 'How to wash cat') }

      before do
        serached_product
      end

      it 'returns serached_product' do
        get '/v1/products?filter[name]=how to'
        expect(json['data'].map { |d| d['id'] }).to eq([serached_product.id])
      end
    end

    context 'with filter[price_from]=&filter[price_to]' do
      it 'returns filtered products' do
        get '/v1/products?filter[price_from]=2&filter[price_to]=3'
        expect(json['data'].map { |d| d['id'] }).to eq(products[2..3].map(&:id))
      end
    end

    context 'with sort by name' do
      it 'ASC' do
        get '/v1/products?sort=name'
        expect(json['data'].map { |d| d['id'] }).to eq(products.sort_by(&:name).map(&:id))
      end

      it 'DESC' do
        get '/v1/products?sort=-name'
        expect(json['data'].map { |d| d['id'] }).to eq(products.sort_by(&:name).reverse.map(&:id))
      end
    end

    context 'with sort by price' do
      it 'ASC' do
        get '/v1/products?sort=price'
        expect(json['data'].map { |d| d['id'] }).to eq(products.sort_by(&:price).map(&:id))
      end

      it 'DESC' do
        get '/v1/products?sort=-price'
        expect(json['data'].map { |d| d['id'] }).to eq(products.sort_by(&:price).reverse.map(&:id))
      end
    end

    context 'with sort by created_at' do
      it 'ASC' do
        get '/v1/products?sort=created_at'
        expect(json['data'].map { |d| d['id'] }).to eq(products.sort_by(&:created_at).map(&:id))
      end

      it 'DESC' do
        get '/v1/products?sort=-created_at'
        expect(json['data'].map { |d| d['id'] }).to eq(products.sort_by(&:created_at).reverse.map(&:id))
      end
    end

    context 'with pagination' do
      before do
        get '/v1/products?page[size]=2&page[number]=2'
      end

      it 'return products with pagination' do
        expect(json['data'].map { |d| d['id'] }).to eq(products[2..3].map(&:id))
      end

      it 'return meta count without pagination' do
        expect(json['meta']['count']).to eq(6)
      end
    end
  end
end
