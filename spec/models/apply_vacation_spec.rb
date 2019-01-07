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
    context 'processing success' do
      it 'normal process' do
        user.paid_holiday_count = 0
        user.save
        expect(apply_vacation.reduce_holiday_count).to eq true
      end

      it 'no count' do
        expect(apply_vacation.reduce_holiday_count).to eq true
      end
    end
    context 'raise error' do
      it 'is rollback' do
        expect(User).to receive(:transaction).and_raise(ActiveRecord::RecordNotSaved)
        expect { apply_vacation.reduce_holiday_count }.to raise_error ActiveRecord::Rollback
      end
    end
  end

  describe 'change_vacation_status' do
    context 'processing success' do
      it 'normal process' do
        expect(apply_vacation.change_vacation_status(:admin_applied)).to eq true
        expect(apply_vacation.status).to eq 'admin_applied'
      end
    end
    context 'raise error' do
      it 'is rollback' do
        expect(apply_vacation).to receive(:save!).and_raise(ActiveRecord::RecordNotSaved)
        expect { apply_vacation.change_vacation_status(:admin_applied) }.to raise_error ActiveRecord::Rollback
      end
    end
  end

  describe 'apply_for_vacation' do
    let(:reason){ '体調不良のため' }
    context 'processing success' do
      it 'normal process' do
        expect(apply_vacation.apply_for_vacation('vacation', user, Date.today, reason)).to eq true
        expect(apply_vacation.status).to eq 'applying'
      end
    end
    context 'raise error' do
      it 'is rollback' do
        expect(ApplyVacation).to receive(:transaction).and_raise(ActiveRecord::RecordNotSaved)
        expect { apply_vacation.apply_for_vacation('vacation', user, Date.today, reason) }.to raise_error ActiveRecord::Rollback
      end
    end
  end

  describe 'apply_cancel' do
    context 'processing success' do
      it 'normal process' do
        expect(apply_vacation.apply_cancel(user, Date.today)).to eq true
        vacation = ApplyVacation.find_by(applicant_id: user.id, get_start_date: Date.today.strftime('%Y-%m-%d'))
        expect(vacation.status).to eq 'withdrawal'
      end
    end

    context 'raise error' do
      it 'is rollback' do
        expect(ApplyVacation).to receive(:transaction).and_raise(ActiveRecord::RecordNotSaved)
        expect { apply_vacation.apply_cancel(user, Date.today) }.to raise_error ActiveRecord::Rollback
      end
    end
  end
end
