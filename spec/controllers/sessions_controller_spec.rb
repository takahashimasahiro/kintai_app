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
    subject { get :new }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #login' do
    let(:params) do
      {
        email: user.email,
        password: user.password
      }
    end
    subject { post :login, params }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
