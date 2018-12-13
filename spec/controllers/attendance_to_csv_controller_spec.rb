require 'rails_helper'

RSpec.describe AttendanceToCsvController, type: :controller do
  let(:user) { User.find(1) }
  let(:apply_vacation) { ApplyVacation.find_by(applicant_id: user.id) }
  let(:attendance_time) { AttendanceTime.find_by(user_id: user.id) }
  let(:params) do
    {
      id: user.id,
      select_year: Date.today.year,
      select_month: Date.today.month,
      select_user: user.id
    }
  end

  before do
    FactoryBot.create :user
    FactoryBot.create :apply_vacation, applicant_id: user.id
    FactoryBot.create :attendance_time, user_id: user.id
    session[:id] = user.id
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, format: :csv, params: params
      expect(response).to have_http_status(:success)
    end
  end
end
