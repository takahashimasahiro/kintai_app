# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #login' do
    let(:email) { user.email }
    let(:password) { user.password }
    it 'returns http success' do
      post :login
      expect(response).to have_http_status(:success)
    end
  end
end
