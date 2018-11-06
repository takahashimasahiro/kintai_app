require 'rails_helper'

RSpec.describe AttendancesController, type: :controller do
  before do
    user = User.new(
      email: 'test@example.com',
      name: 'testuser',
      password: 'password')
    user.save
  end
  describe 'GET #new' do
    subject { get :new }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET #show' do
    let(:current_user) { User.find(1) }
    subject { get :show, params }
    let(:params) do
      {
        id: 1
      }
    end
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
