require 'rails_helper'

RSpec.describe AttendancesController, type: :controller do

  let(:user) { User.create(
    email: 'test@example.com',
    name: 'testuser',
    password: 'password')}

  before do
    user
  end
  describe 'GET #new' do
    subject { get :new }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET #show' do
    let(:params) { { id: 1 } }
    subject { get :show, params }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'PATCH #update' do
    subject { patch :update }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
