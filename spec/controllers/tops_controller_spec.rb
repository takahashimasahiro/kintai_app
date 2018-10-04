require 'rails_helper'

RSpec.describe TopsController, type: :controller do
<<<<<<< HEAD
  describe 'GET #top' do
    describe '200 OKとなる' do
      describe 'users/homeを表示する' do
        #   expect(response).to have_http_status(:success)
      end
      describe 'tops/newを表示する' do
        #   expect(response).to have_http_status(:success)
      end
      #   expect(response).to have_http_status(:success)
    end
    describe 'flashを表示する' do
      it 'ログインが必要です' do
        #   expect(response).to have_http_status(:success)
      end
      #   expect(response).to have_http_status(:success)
    end

    describe 'エラーメッセージを表示する' do
      it 'emailまたはpasswordが間違っている' do
        #   expect(response).to have_http_status(:success)
      end
      #   expect(response).to have_http_status(:success)
    end
  end
=======

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

>>>>>>> 必要ファイルの追加
end
