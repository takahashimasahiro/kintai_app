require 'rails_helper'

RSpec.describe AttendanceTime, type: :model do
  
  describe "vacation?" do
    it 'vacation' do
      expect(AttendanceTime.vacation?('vacation')).to eq true
    end

    it 'not vacation' do
      expect(AttendanceTime.vacation?('work')).to eq false
    end
  end

  describe "first_month" do
    let(:time_now){ Time.zone.now }
    before do
      allow(Time).to receive_message_chain(:zone, :now).with(no_args).with(no_args).and_return(time_now)
    end

    it 'success' do
      expect(AttendanceTime.first_month(time_now.year,time_now.month)).to eq time_now.change(day: 1)
    end
    it 'failed' do
      expect(AttendanceTime.first_month(nil,nil)).to eq time_now
    end
  end
end
