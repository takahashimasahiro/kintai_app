require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create :user }

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create　ユーザーの作成' do
    let(:params) do
      {
        id: user.id,
        user: {
          email: 'test@example.com',
          name: 'testuser',
          password: 'password'
        }
      }
    end

    let(:user_params) do
      ActionController::Parameters.new(email: 'test@example.com',
                                       password: 'password',
                                       name: 'testuser')
    end

    context '成功した時' do
      it 'ログインに成功すること' do
        expect(User).to receive(:new).with(user_params.permit(:email, :password, :name)).and_return(user)
        expect(user).to receive(:save).and_return(true)
        post :create, params: params
        expect(session[:id]).to eq user.id
        expect(response).to redirect_to attendance_path(user.id)
      end
    end
    context '失敗した時' do
      it '元の画面に戻ること' do
        expect(User).to receive(:new).with(user_params.permit(:email, :password, :name)).and_return(user)
        expect(user).to receive(:save).and_return(false)
        post :create, params: params
        expect(session[:id]).to eq nil
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #edit' do
    let(:params) { { id: user.id } }
    it 'returns http success' do
      session[:id] = 1
      get :edit, params: params
      expect(@user).to eq @current_user
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCh #update' do
    let(:new_name){'user_new_name'}
    let(:new_password){'new_password'}
    let(:params) do
      {
        id: user.id,
        page: {
          name: new_name
        },
        user: {
          old_password: user.password,
          new_password1: new_password,
          new_password2: new_password
        }
      }
    end
    before do
      session[:id] = 1
    end
    
    it 'returns http success' do
      patch :update, params: params
      expect(response).to redirect_to edit_user_path(user.id)
    end
    context 'update faild' do
      it 'save faild' do
        expect(User).to receive(:find).with(session[:id]).and_return(user)
        expect(user).to receive(:save).and_return(false)
        patch :update, params: params
        expect(response).to render_template :edit
      end

      it 'wrong password' do
        params[:user][:new_password2] = new_password.reverse
        patch :update, params: params
        expect(response).to render_template :edit
      end
    end
  end
end
