require 'rails_helper'

RSpec.describe AttendanceTime, type: :model do
  let(:user) { User.find(1) }
  let(:apply_vacation) { ApplyVacation.find_by(applicant_id: user.id) }
  let(:attendance_time) { AttendanceTime.find_by(user_id: user.id) }

  before do
    FactoryBot.create :user
    FactoryBot.create :apply_vacation, applicant_id: user.id
    FactoryBot.create :attendance_time, user_id: user.id
  end

  describe 'vacation?' do
    it 'vacation' do
      expect(AttendanceTime.vacation?('vacation')).to eq true
    end

    it 'not vacation' do
      expect(AttendanceTime.vacation?('work')).to eq false
    end
  end

  describe 'first_month' do
    let(:time_now) { Time.zone.now }
    before do
      allow(Time).to receive_message_chain(:zone, :now).with(no_args).with(no_args).and_return(time_now)
    end

    it 'success' do
      expect(AttendanceTime.first_month(time_now.year, time_now.month)).to eq time_now.change(day: 1)
    end
    it 'failed' do
      expect(AttendanceTime.first_month(nil, nil)).to eq time_now
    end
  end

  describe 'change_attend_status' do
    it 'success' do
      expect(attendance_time.change_attend_status(apply_vacation, :vacation)).to eq true
      attend_data = AttendanceTime.find_by(user_id: apply_vacation.applicant_id, work_date: apply_vacation.get_start_date)
      expect(attend_data.status).to eq 'vacation'
    end
  end
end
