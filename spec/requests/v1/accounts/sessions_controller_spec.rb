# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Accounts::SessionsController, type: :request do
  describe 'POST #create_session' do
    let(:user) { create(:user, :confirmed, password: '0000') }
    let(:default_request) do
      post '/v1/accounts/session', params: params
    end

    context 'when authorized' do
      let(:params) {}

      before do
        sign_in user

        default_request
      end

      it 'respond with 403' do
        expect(response.status).to eq(403)
      end

      it 'respond with error' do
        expect(json['errors']).not_to be_nil
      end
    end

    context 'with valid params' do
      let(:params) do
        {
          data: {
            type: 'session',
            attributes: {
              email: user.email,
              password: '0000'
            }
          }
        }
      end

      it 'respond with 200' do
        default_request

        expect(response.status).to eq(200)
      end

      it 'respond with user' do
        default_request

        expect(json['data']['id']).to eq(user.id)
      end

      it 'create redis record' do
        expect do
          default_request
        end.to change { Redis.session.keys.count }.by(1)
      end

      it 'sets cookies' do
        default_request

        expect(Redis.session.exists("session:test:#{response.cookies['_store_test_session']}")).to eq(1)
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          data: {
            type: 'session',
            attributes: {
              email: 'fake',
              password: '0000'
            }
          }
        }
      end

      it 'respond with 403' do
        default_request

        expect(response.status).to eq(403)
      end

      it 'respond with error' do
        default_request

        expect(json['errors'][0]['detail']).to eq('Incorrect email or password')
      end
    end
  end

  describe 'DELETE /v1/account/session' do
    let(:user) { create(:user) }

    let(:default_request) do
      delete '/v1/accounts/session'
    end

    context 'when unauthorized' do
      it 'respond with 401' do
        default_request

        expect(response.status).to eq(401)
      end

      it 'respond with error' do
        default_request

        expect(json['errors']).not_to be_nil
      end
    end

    context 'when authorized' do
      before do
        sign_in user
      end

      it 'respond with 204' do
        default_request

        expect(response.status).to eq(204)
      end

      it 'logouts user' do
        default_request

        expect(controller.current_user).to be_nil
      end
    end
  end
end
