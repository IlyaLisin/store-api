# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::PurchaseOrdersController, type: :request do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:default_request) do
      post '/v1/purchase_orders', params: params.to_json, headers: { 'Content-Type': 'application/json' }
    end

    context 'when unauthorized' do
      let(:params) {}

      before do
        default_request
      end

      it 'respond with 401' do
        expect(response.status).to eq(401)
      end

      it 'respond with error' do
        expect(json['errors']).not_to be_nil
      end
    end

    context 'with valid params' do
      let(:product) { create(:product) }
      let(:params) do
        {
          data: {
            type: 'purchase_order',
            relationships: {
              purchase_orders_products: {
                data: [{
                  type: 'purchase_orders_product',
                  attributes: {
                    product_id: product.id,
                    amount: 2
                  }
                }]
              }
            }
          }
        }
      end

      before do
        sign_in user
      end

      it 'respond with 200' do
        default_request

        expect(response.status).to eq(200)
      end

      it 'creates purchase order' do
        expect do
          default_request
        end.to change(PurchaseOrder, :count).by(1)
      end

      it 'creates purchase order product' do
        expect do
          default_request
        end.to change(PurchaseOrdersProduct, :count).by(1)
      end

      it 'recount available product count' do
        expect do
          default_request
        end.to change { product.reload.available_count }.by(-2)
      end

      it 'respond with purchase order' do
        default_request

        expect(json['data']['id']).to eq(PurchaseOrder.last.id)
      end
    end

    context 'when products count is too low' do
      let(:product) { create(:product, available_count: 0) }
      let(:params) do
        {
          data: {
            type: 'purchase_order',
            relationships: {
              purchase_orders_products: {
                data: [{
                  type: 'purchase_orders_product',
                  attributes: {
                    product_id: product.id,
                    amount: 2
                  }
                }]
              }
            }
          }
        }
      end

      before do
        sign_in user
      end

      it 'respond with 422' do
        default_request

        expect(response.status).to eq(422)
      end

      it 'does not create purchase order' do
        expect do
          default_request
        end.to change(PurchaseOrder, :count).by(0)
      end

      it 'does not create purchase order product' do
        expect do
          default_request
        end.to change(PurchaseOrdersProduct, :count).by(0)
      end
    end
  end
end
