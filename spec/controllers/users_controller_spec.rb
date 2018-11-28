require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create :user }
  # let(:params) { user {
  #                   email = 'test@example.com',
  #                   name = 'testuser',
  #                   password = 'password'
  #                 }
  #               }

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe 'POST #create　ユーザーの作成' do
    context '成功した時' do
      it 'ログインに成功すること' do
        create_user = double(@user)
        # user_param = double('user_params')
        # allow(user_param).to receive().and_return()
        expect(User.find(user.id)).to receive(User.new).with(params[:user])
        allow(create_user).to receive(:new).and_return(User.find(user.id))
        allow(create_user).to receive(:save).and_return(true)
        allow(create_user).to receive(:id).and_return(user.id)
        p user.id
        p create_user.id
        post :create, params: params
        expect(response).to redirect_to attendance_path(user.id)
      end
    end
    xcontext '失敗した時' do
      it '元の画面に戻ること' do
        # TODO user.saveをfalseに置き換え
        
      end
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      session[:id] = 1
      # user = User.find(1)
      params = {
        id: user.id
      }
      get :edit, params: params
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCh #update' do
    it 'returns http success' do
      session[:id] = 1
      # user = User.find(1)
      params = {
        id: user.id,
        page: {
          name: 'user_new_name'
        },
        user: {
          old_password: user.password,
          new_password1: 'new_password',
          new_password2: 'new_password'
        }
      }
      patch :update, params: params
      expect(response).to have_http_status '302'
    end
  end
end
