require 'rails_helper'

RSpec.describe UserManagementsController, type: :controller do
  describe 'GET #index' do
    subject { get :index, params }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
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

  describe 'PATCH #update' do
    subject { patch :update }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

end
