require 'rails_helper'

RSpec.describe HolidaysController, type: :controller do
  include ApplicationHelperSpec
  session = { 'id' => 1 }
  let(:user) { User.create(
    id: 1,
    email: 'test@example.com',
    name: 'testuser',
    password: 'password') }
  before do
    user
    add_session(session)
  end

  describe 'GET #show' do
    let(:id) { 1 }
    it 'returns http success' do
      get :show, params: { id: id }
      expect(response).to have_http_status(:success)
    end
  end

  describe ' #edit' do
    it 'returns http success' do
      get :edit, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe ' #update' do
  params = {
    id: 1,
    user_id: 1,
    get_date: Date.today,
    approve: nil,
    dismiss: nil
  }
    it '申請許可' do
      params[:approve] = ""
      params[:dismiss] = nil
      patch :update, params: params
      expect(response).to have_http_status '302'
    end

    it '申請却下' do
      params[:approve] = nil
      params[:dismiss] = ""
      patch :update, params: params
      expect(response).to have_http_status '302'
    end
  end
end
