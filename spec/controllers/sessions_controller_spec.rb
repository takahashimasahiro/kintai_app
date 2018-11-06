require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    subject { get :new }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #login' do
    subject { post :login }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
