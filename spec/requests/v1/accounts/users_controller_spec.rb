# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Accounts::UsersController, type: :request do
  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:default_request) do
      get '/v1/accounts'
    end

    context 'when unauthorized' do
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

    context 'when authorized' do
      before do
        sign_in user

        default_request
      end

      it 'respond with 200' do
        expect(response.status).to eq(200)
      end

      it 'return user' do
        expect(json['data']['id']).to eq(user.id)
      end
    end
  end
end
