require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { User.create(
    email: 'test@example.com',
    name: 'testuser',
    password: 'password') }
  before do
    user
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'リダイレクトが繰り返し呼ばれていないこと' do
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
