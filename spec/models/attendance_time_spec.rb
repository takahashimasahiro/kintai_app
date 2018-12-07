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

  # TODO かく
  describe 'update_attend' do
    context 'is success' do
      it 'work → vaction' do
      end
      it 'vacation → work' do
      end
      it 'vacation → aother vacation' do
      end
      xit 'holiday → holiday_work' do
      end
    end
    context 'raise error' do
      it 'update false' do
      end
    end
  end
  
  describe 'include_vacation?' do
    it 'is vacation' do
      expect(AttendanceTime.new.include_vacation?('vacation')).to eq true
    end

    it 'not vacation' do
      expect(AttendanceTime.new.include_vacation?('work')).to eq false
    end
  end

  describe 'first_month' do
    let(:date_now) { Date.today }
    before do
      allow(Date).to receive(:today).with(no_args).and_return(date_now)
    end

    it 'success' do
      expect(AttendanceTime.first_month(date_now.year, date_now.month)).to eq date_now.change(day: 1)
    end
    it 'failed' do
      expect(AttendanceTime.first_month(nil, nil)).to eq date_now
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
