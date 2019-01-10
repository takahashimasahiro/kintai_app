require 'rails_helper'

RSpec.describe UserHolidayController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:vacation) { FactoryBot.create(:apply_vacation, applicant_id: user.id) }

  before do
    vacation
    session[:id] = '1'
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
      expect(ApplyVacation.all.size).to eq 1
    end
  end
  describe 'PATCH #update' do
    let(:params) do
      {
        id: 1,
        date: Date.today,
        reason: 'TEST'
      }
    end
    it 'returns http success' do
      patch :update, params: params
      expect(response).to redirect_to user_holiday_path(user.id)
    end
  end
end
