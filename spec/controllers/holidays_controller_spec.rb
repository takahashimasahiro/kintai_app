require 'rails_helper'

RSpec.describe HolidaysController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:vacation) { FactoryBot.create(:apply_vacation, applicant_id: user.id) }

  before do
    user
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

  describe ' #edit' do
    it 'returns http success' do
      get :edit, params: { id: :id }
      expect(response).to have_http_status(:success)
    end
  end

  describe ' #update' do
    let(:params) do
      {
        id: '1',
        user_id: '1',
        get_date: Date.today.strftime('%Y-%m-%d'),
        approve: nil,
        dismiss: nil,
        button: nil
      }
    end

    it '申請許可' do
      params[:button] = 'apply_rejection'
      expect(ApplyVacation).to receive(:find_by).with(applicant_id: params[:user_id], get_start_date: params[:get_date]).and_return(vacation)
      expect(vacation).to receive(:reduce_holiday_count).and_return(user)
      expect(vacation).to receive(:save!).and_return(true)
      patch :update, params: params
      expect(response).to redirect_to edit_holiday_path(user.id)
    end

    it '申請却下' do
      params[:button] = 'admin_applied'
      expect(ApplyVacation).to receive(:find_by).with(applicant_id: params[:user_id], get_start_date: params[:get_date]).and_return(vacation)
      expect(vacation).to receive(:change_vacation_status).with(:absence)
      expect(vacation).to receive(:save!).and_return(false)
      patch :update, params: params
      expect(response).to redirect_to edit_holiday_path(user.id)
    end
  end
end
