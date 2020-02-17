# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Accounts::RegistrationsController, type: :request do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:default_request) do
      post '/v1/accounts/sign_up', params: params
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
            type: 'user',
            attributes: {
              name: 'name',
              password: '12345',
              email: 'user@example.com'
            }
          }
        }
      end

      it 'respond with 204' do
        default_request

        expect(response.status).to eq(204)
      end

      it 'creates user' do
        expect do
          default_request
        end.to change(User, :count).by(1)
      end

      it 'creates user with unconfirmed email' do
        default_request

        expect(User.find_by(email: 'user@example.com').confirmed?).to eq(false)
      end

      it 'creates user with confirmation token' do
        default_request

        expect(User.find_by(email: 'user@example.com').confirmation_token).not_to be_nil
      end

      it 'creates job for sending confirmation email' do
        expect do
          default_request
        end.to have_enqueued_job.on_queue('mailers')
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          data: {
            type: 'user',
            attributes: {
              name: 'name',
              password: '12345',
              email: 'invalid'
            }
          }
        }
      end

      it 'respond with 422' do
        default_request

        expect(response.status).to eq(422)
      end

      it 'respond with error' do
        default_request

        expect(json['errors'][0]['detail']).to eq('Email is invalid')
      end

      it 'does not creates user' do
        expect do
          default_request
        end.to change(User, :count).by(0)
      end
    end
  end

  describe 'POST #confirm_email' do
    let(:user) { create(:user, :with_confirmation_token) }
    let(:default_request) do
      patch '/v1/accounts/email_confirmation'
    end

    context 'when authorized' do
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

    context 'with valid token' do
      let(:default_request) do
        patch "/v1/accounts/email_confirmation?confirmation_token=#{user.confirmation_token}"
      end

      it 'respond with 204' do
        default_request

        expect(response.status).to eq(204)
      end

      it 'confirm email' do
        expect do
          default_request
          user.reload
        end.to change(user, :confirmed?).from(false).to(true)
      end
    end
  end
end
