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

  describe 'update_attend' do
    let(:reason){ '体調不良のため' } #申請理由
    context 'is success' do
      it 'work → vaction' do
        expect(ApplyVacation).to receive_message_chain(:new, :apply_for_vacation)
          .with(no_args).with('vacation', user, Date.today, reason)
          .and_return([])
        expect(attendance_time.update_attend(user, 'vacation', reason)).to eq true
        expect(attendance_time.work_start.hour).to eq 0
        expect(attendance_time.work_start.min).to eq 0
        expect(attendance_time.work_end.hour).to eq 0
        expect(attendance_time.work_end.min).to eq 0
      end
      it 'vacation → work' do
        attendance_time.status = 'vacation'
        attendance_time.save
        expect(ApplyVacation).to receive_message_chain(:new, :apply_cancel)
          .with(no_args).with(user, Date.today)
          .and_return([])
        expect(attendance_time.update_attend(user, 'work', reason)).to eq true
      end
      it 'vacation → aother vacation' do
        attendance_time.status = 'vacation'
        attendance_time.save
      end
    end
    context 'raise error' do
      it 'update false' do
        expect(attendance_time).to receive(:save!).and_raise(ActiveRecord::RecordNotSaved)
        expect(ApplyVacation).to receive_message_chain(:new, :apply_for_vacation)
          .with(no_args).with('vacation', user, Date.today, reason)
          .and_return([])
        expect { attendance_time.update_attend(user, 'vacation', reason) }.to raise_error(ActiveRecord::Rollback)
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
      expect(AttendanceTime.first_month(nil, nil)).to eq date_now.change(day: 1)
    end
  end

  describe 'change_attend_status' do
    context 'processing success' do
      it 'normal prcess' do
        expect(attendance_time.change_attend_status(apply_vacation, :vacation)).to eq true
        attend_data = AttendanceTime.find_by(user_id: apply_vacation.applicant_id, work_date: apply_vacation.get_start_date)
        expect(attend_data.status).to eq 'vacation'
      end
    end

    context 'raise error' do
      it 'is RollBack' do
        expect(AttendanceTime).to receive(:transaction).and_raise(ActiveRecord::RecordNotSaved)
        expect { attendance_time.change_attend_status(apply_vacation, :vacation) }.to raise_error(ActiveRecord::Rollback)
      end
    end
  end
end
