require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { FactoryBot.create :user }
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #index' do
    let(:params) do
      {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it 'returns http success' do
      get :index, params: params
      expect(response).to redirect_to attendance_path(user.id)
    end

    it 'login faild' do
      params[:user][:password] = user.password.reverse
      get :index, params: params
      expect(response).to render_template :new
    end
  end
  describe '#destroy' do
    let(:params) { { id: user.id } }
    it 'returns http success' do
      delete :destroy, params: params
      expect(response).to redirect_to '/'
    end
  end
end
