require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { User.create(
    email: 'test@example.com',
    name: 'testuser',
    password: 'password') }

  before do
    user
  end
  describe 'GET #new' do
    subject { get :new }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST #create' do
    subject { post :create }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    subject { get :edit }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCh #update' do
    subject { patch :update, params }
    let(:params) do
      {
        page: {
          name: 'user_new_name'
        },
        name: {
          old_password: user.password,
          new_password1: 'new_password',
          new_password2: 'new_password'
        }
      }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
