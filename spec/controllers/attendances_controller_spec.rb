require 'rails_helper'
# TODO: specのDIY
RSpec.describe AttendancesController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:attendance_time) { FactoryBot.create :attendance_time, user_id: user.id }
  before do
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
    let(:work_date) { Date.new(2018, 11, 1) }

    it 'returns http success' do
      patch :update, params: params, as: :json
      expect(response).to redirect_to attendance_path(user.id)
      expect(AttendanceTime.all.size).to eq 1
      attend_time = AttendanceTime.find_by(user_id: user.id, work_date: work_date)
      expect(attend_time.status).to eq 'work'
      expect(flash[:notice]).to eq '保存しました'
    end

    it 'returns http failed' do
      expect(AttendanceTime).to receive(:find_or_initialize_by)
        .with(user_id: user.id, work_date: work_date)
        .and_return(attendance_time)
      expect(attendance_time).to receive(:update_attend).with(user, params[:change_status]).and_return(false)
      patch :update, params: params, as: :json
      expect(response).to redirect_to attendance_path(user.id)
      expect(flash[:notice]).to eq '保存に失敗しました'
    end

    it 'is some error' do
      expect(AttendanceTime).to receive(:find_or_initialize_by)
        .with(user_id: user.id, work_date: work_date)
        .and_return(attendance_time)
      expect(attendance_time).to receive(:update_attend)
        .with(user, params[:change_status])
        .and_raise(ActiveRecord::RecordNotSaved)
      patch :update, params: params, as: :json
      expect(response).to redirect_to attendance_path(user.id)
      expect(flash[:notice]).to eq '保存に失敗しました'
    end
  end
end
