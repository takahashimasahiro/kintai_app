require 'rails_helper'

RSpec.describe AttendanceToCsvHelper, type: :module do
  let(:test_class) { Struct.new(:attendances_helper) { include AttendanceToCsvHelper } }
  let(:helper) { test_class.new }
  let(:date) { Date.today }

  describe 'absence?' do
    it 'is weekend' do
      expect(helper).to receive(:weekend?).with(date).and_return(true)
      expect(helper.absence?(date)).to eq :holiday
    end
    it 'is weekday' do
      expect(helper).to receive(:weekend?).with(date).and_return(false)
      expect(helper.absence?(date)).to eq :absence
    end
  end

  describe 'work_day?' do
    it 'is weekend' do
      expect(helper).to receive(:weekend?).with(date).and_return(true)
      expect(helper.work_day?(date)).to eq :holiday
    end
    it 'is weekday' do
      expect(helper).to receive(:weekend?).with(date).and_return(false)
      expect(helper.work_day?(date)).to eq :work
    end
  end
end
