require 'rails_helper'

RSpec.describe UserManagementsController, type: :controller do
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
    add_session(session)
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      params = {
        id: 1
      }
      get :new, params: params
      expect(response).to have_http_status(:success)
    end
  end

  describe 'user create or update' do
    params = {
      id: 1,
      page: {
        email: 'test@example.com',
        name: 'testuser',
        password: 'password'
      },
      holiday_count: 10,
      role: 'owner'
    }
    describe 'POST #create' do
      it 'returns http success' do
        post :create, params: params
        expect(response).to have_http_status(:success)
      end
    end

    describe 'PATCH #update' do
      it 'returns http success' do
        patch :update, params: params
        expect(response).to have_http_status '302'
      end
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      params = {
        id: 1
      }
      get :edit, params: params
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns http success' do
      params = {
        id: 1
      }
      delete :destroy, params: params
      expect(response).to have_http_status '302'
    end
  end
end
