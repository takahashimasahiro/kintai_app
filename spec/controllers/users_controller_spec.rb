require 'rails_helper'
<<<<<<< HEAD
RSpec.describe UsersController, type: :controller do
  describe 'GET /' do
    it 'returns http success' do
=======

RSpec.describe UsersController, type: :controller do

  describe "GET #login" do
    it "returns http success" do
>>>>>>> 必要ファイルの追加
      get :login
      expect(response).to have_http_status(:success)
    end
  end

<<<<<<< HEAD
  describe 'GET /users/home' do
    it 'returns http success' do
      # get :
    end
  end
=======
>>>>>>> 必要ファイルの追加
end
