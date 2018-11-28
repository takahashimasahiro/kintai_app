require 'rails_helper'

RSpec.describe HolidaysController, type: :controller do
  let(:id) { '1' }
  before do
    FactoryBot.create :user
    session[:id] = 1
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: :id }
      expect(response).to have_http_status(:success)
    end
  end

  describe ' #edit' do
    it 'returns http success' do
      get :edit, params: { id: :id }
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe ' #update' do
    # before do
    # FactoryBot.create :apply_vacation, applicant_id: :id
    # end
    params = {
      id: 1,
      user_id: '1',
      get_date: Date.today,
      approve: nil,
      dismiss: nil
    }
    it '申請許可' do
      p User.first
      p ApplyVacation.first
      FactoryBot.create :apply_vacation, applicant_id: :id
      p ApplyVacation.first

      params[:approve] = ''
      params[:dismiss] = nil
      p params[:user_id]
      p params[:get_date]

      patch :update, params: params
      expect(response).to have_http_status '302'
    end

    it '申請却下' do
      FactoryBot.create(:apply_vacation)
      params[:approve] = nil
      params[:dismiss] = ''
      patch :update, params: params
      expect(response).to have_http_status '302'
    end
  end
end
