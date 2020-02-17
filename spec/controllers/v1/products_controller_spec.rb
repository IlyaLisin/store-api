# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ProductsController, type: :request do
  describe 'GET #index' do
    let(:products) { create_list(:product, 6) }
    let(:default_request) do
      get '/v1/products'
    end

    before do
      products
      default_request
    end

    it 'respond with 200' do
      expect(response.status).to eq(200)
    end

    it 'return products list' do
      expect(json['data'].map { |d| d['id'] }).to match_array(products.map(&:id))
    end

    context 'when pagination is' do
      before do
        products

        get '/v1/products?page[size]=2&page[number]=1'
      end

      it 'return products with pagination' do
        expect(json['data'].map { |d| d['id'] }).to match_array(products[2..3].map(&:id))
      end

      it 'return meta count without pagination' do
        expect(json['meta']['count']).to eq(6)
      end
    end
  end
end
