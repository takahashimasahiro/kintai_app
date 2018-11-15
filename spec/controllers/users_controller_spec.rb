# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include ApplicationHelperSpec
  session = { 'id' => 1 }
  let(:user) do
    User.create(
      id: 1,
      email: 'test@example.com',
      name: 'testuser',
      password: 'password'
    )
  end

  before do
    user
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'returns http success' do
      params = {
        user: {
          email: 'test@example.com',
          name: 'testuser',
          password: 'password'
        }
      }
      post :create, params: params
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      params = {
        id: user.id
      }
      add_session(session)
      get :edit, params: params
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCh #update' do
    it 'returns http success' do
      params = {
        id: user.id,
        page: {
          name: 'user_new_name'
        },
        user: {
          old_password: user.password,
          new_password1: 'new_password',
          new_password2: 'new_password'
        }
      }
      add_session(session)
      patch :update, params: params
      expect(response).to have_http_status '302'
    end
  end
end
