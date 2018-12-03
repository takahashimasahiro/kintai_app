require 'rails_helper'

RSpec.describe ApplyVacation, type: :model do
  let(:user) { User.find(1) }
  let(:apply_vacation) { ApplyVacation.find_by(applicant_id: user.id) }
  let(:attendance_time) { AttendanceTime.find_by(user_id: user.id) }

  before do
    FactoryBot.create :user
    FactoryBot.create :apply_vacation, applicant_id: user.id
    FactoryBot.create :attendance_time, user_id: user.id
  end

  describe 'reduce_holiday_count' do
    it 'success' do
      user.paid_holiday_count = 0
      user.save
      expect(AttendanceTime).to receive_message_chain(:new, :change_attend_status).with(no_args).with(apply_vacation, :absence).and_return([])
      expect(apply_vacation.reduce_holiday_count).to eq true
    end

    it 'no count' do
      expect(apply_vacation).to receive(:change_vacation_status).with(:admin_applied)
      expect(apply_vacation.reduce_holiday_count).to eq true
    end
  end

  describe 'change_vacation_status' do
    it 'success' do
      expect(apply_vacation.change_vacation_status(:admin_applied)).to eq true
      expect(apply_vacation.status).to eq 'admin_applied'
    end
  end

  describe 'apply_for_vacation' do
    it 'success' do
      expect(apply_vacation.apply_for_vacation('vacation', user, Date.today)).to eq true
      expect(apply_vacation.status).to eq 'applying'
    end
  end

  describe 'apply_cancel' do
    it 'success' do
      expect(apply_vacation.apply_cancel(user, Date.today)).to eq true
      vacation = ApplyVacation.find_by(applicant_id: user.id, get_start_date: Date.today.strftime('%Y-%m-%d'))
      expect(vacation.status).to eq 'withdrawal'
    end
  end
end
