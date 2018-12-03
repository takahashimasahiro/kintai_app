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
        change_rows: '1',
        "status_#{user.id}": 'work',
        "work_#{user.id}": {
          "start(1i)": '2018',
          "start(2i)": '11',
          "start(3i)": '1',
          "start(4i)": '10',
          "start(5i)": '0',
          "end(1i)": '2018',
          "end(2i)": '11',
          "end(3i)": '1',
          "end(4i)": '19',
          "end(5i)": '0'
        }
      }
    end

    it 'returns http success' do
      patch :update, params: params, as: :json
      expect(response).to redirect_to attendance_path(user.id)
      expect(AttendanceTime.all.size).to eq 1
      attend_time = AttendanceTime.find_by(user_id: user.id, work_date: Date.new(2018,11,1))
      expect(attend_time.status).to eq 'work'
    end
  end
end
