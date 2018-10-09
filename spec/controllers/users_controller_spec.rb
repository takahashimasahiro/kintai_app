require 'rails_helper'
<<<<<<< HEAD
<<<<<<< HEAD
RSpec.describe UsersController, type: :controller do
  describe 'GET /' do
    it 'returns http success' do
=======

RSpec.describe UsersController, type: :controller do

  describe "GET #login" do
    it "returns http success" do
>>>>>>> 必要ファイルの追加
=======
RSpec.describe UsersController, type: :controller do
  describe 'GET /' do
    it 'returns http success' do
>>>>>>> 10月5日分
      get :login
      expect(response).to have_http_status(:success)
    end
  end

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 10月5日分
  describe 'GET /users/home' do
    it 'returns http success' do
      # get :
    end
  end
<<<<<<< HEAD
=======
>>>>>>> 必要ファイルの追加
=======
>>>>>>> 10月5日分
end
