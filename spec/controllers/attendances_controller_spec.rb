require 'rails_helper'

RSpec.describe AttendancesController, type: :controller do
  let(:user) { FactoryBot.create :user }

  before do
    user
    session[:id] = 1
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    let(:params)  do
      {
        id: user.id,
        select_year: '2018',
        select_month: '11',
        change_rows: '1',
        change_day: '1',
        change_start_hour: '10',
        change_start_minute: '00',
        change_end_hour: '19',
        change_end_mitute: '00',
        change_status: 'work'
      }
    end

    it 'returns http success' do
      patch :update, params: params, as: :json
      expect(response).to redirect_to attendance_path(user.id)
      expect(AttendanceTime.all.size).to eq 1
      attend_time = AttendanceTime.find_by(user_id: user.id, work_date: Date.new(2018, 11, 1))
      expect(attend_time.status).to eq 'work'
    end
  end
end
