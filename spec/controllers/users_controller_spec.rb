require 'rails_helper'

# TODOルートに合わせる
RSpec.describe UsersController, type: :controller do
  describe "GET #login" do
    it "returns http success" do
      
    end
  end
  
  describe 'GET /' do
    it 'returns http success' do
      get :login
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /users/home' do
    it 'returns http success' do
      # get :
    end
  end
end
