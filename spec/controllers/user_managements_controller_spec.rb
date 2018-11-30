require 'rails_helper'

RSpec.describe UserManagementsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before do
    session[:id] = '1'
    expect(User).to receive(:find).with(session[:id]).and_return(user)
  end

  describe 'GET #index' do
    it 'returns http success' do
      expect(User).to receive_message_chain(:all,:order)
                                            .with(no_args).with(:id)
                                            .and_return([])
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    let(:params){{id: 1}}
    it 'returns http success' do
      expect(User).to receive(:new)
      get :new, params: params
      expect(response).to have_http_status(:success)
    end
  end

  describe 'user create or update' do
    let(:params) do {
        holiday_count: "10",
        page: {
          email: 'test@example.com',
          name: 'testuser',
          password: 'password'
        },
        role: 'owner',
        id: "1"
      }
    end
    describe 'POST #create' do
      it 'returns http success' do
        expect(User).to receive(:new).and_return(user)
        expect(user).to receive(:save).and_return(true)
        post :create, params: params
        expect(response).to redirect_to user_managements_path
      end
      
      it 'returns http Failed' do
        expect(User).to receive(:new).and_return(user)
        expect(user).to receive(:save).and_return(false)
        post :create, params: params
        expect(response).to have_http_status :success
      end
    end

    describe 'PATCH #update' do

      it 'returns http success' do
        expect(User).to receive(:find).with(session[:id]).and_return(user)
        expect(user).to receive(:save).and_return(true)
        params[:page][:password] = ""
        patch :update, params: params
        expect(response).to redirect_to user_managements_path
      end

      it 'returns http Failed' do
        expect(User).to receive(:find).with(session[:id]).and_return(user)
        expect(user).to receive(:save).and_return(false)
        patch :update, params: params
        expect(response).to have_http_status :success
      end
    end
  end

  describe 'GET #edit' do
    let(:params){{id: 1}}
    it 'returns http success' do
      expect(User).to receive(:find)
      get :edit, params: params
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    let(:params){{id: 1}}
    it 'returns http success' do
      expect(User).to receive(:find).and_return(user)
      expect(user).to receive(:destroy).and_return(true)
      delete :destroy, params: params
      expect(response).to redirect_to user_managements_path
    end
  end
end




