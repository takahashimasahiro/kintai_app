require 'rails_helper'

RSpec.describe UserManagementsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before do
    user
    session[:id] = 1
    expect(User).to receive_message_chain(:find,:owner?).with(session[:id]).with(no_args).and_return([])
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
        post :create, params: params
        expect(response).to have_http_status '302'
      end
    end

    describe 'PATCH #update' do
      it 'returns http success' do
        p params[:page][:email]
        patch :update, params: params
        expect(response).to have_http_status '302'
      end
    end
  end

  xdescribe 'GET #edit' do
    let(:params){{id: 1}}
    it 'returns http success' do
      get :edit, params: params
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe 'DELETE #destroy' do
    let(:params){{id: 1}}
    it 'returns http success' do
      delete :destroy, params: params
      expect(response).to have_http_status '302'
    end
  end
end




