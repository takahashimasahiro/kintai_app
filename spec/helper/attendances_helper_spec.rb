require 'rails_helper'

RSpec.describe AttendancesHelper, type: :module do
  let(:test_class) { Struct.new(:attendances_helper) { include AttendancesHelper } }
  let(:helper) { test_class.new }
  let(:date) { Date.new(2018, 5, 2) } # 水曜日,平日
  let(:user) { FactoryBot.create :user }
  let(:attendance_time) { FactoryBot.create :attendance_time, user_id: user.id }

  describe 'date_of_week' do
    it 'normal process' do
      expect(helper.date_of_week(0)).to eq '日'
    end
  end

  describe 'all_status' do
    it 'normal process' do
      expect(helper.all_status.length).to eq 7
      expect(helper.all_status[:work]).to eq '出勤'
    end
  end

  describe 'create_day_of_week_classname' do
    it 'is holiday' do
      expect(helper).to receive(:holiday?).with(date).and_return(true)
      expect(helper.create_day_of_week_classname(date)).to eq 'holiday'
    end

    it 'is not holiday' do
      expect(helper).to receive(:holiday?).with(date).and_return(false)
      expect(helper.create_day_of_week_classname(date)).to eq Date.new(2018, 5, 2).wday
    end
  end

  describe 'show_years_map' do
    it 'normal process' do
      years = (2008..2028).map { |x| x }
      expect(helper.show_years_map(date)).to eq years
    end
  end

  describe 'choice_attendanceTime' do
    it 'normal process' do
      expect(helper.choice_attendanceTime([attendance_time], Date.today)).to eq attendance_time
    end

    it 'no data' do
      expect(helper.choice_attendanceTime([attendance_time], Date.tomorrow)).to be_nil
    end
  end

  xdescribe 'show_start_attendanceTime' do
    # TODO
    it 'has data' do
      expect(helper).to receive(:time_select)
      expect(helper.show_start_attendanceTime(attendance_time, Date.today)).to eq ''
    end

    it 'not data' do
      expect(helper).to receive(:time_select)
    end
  end

  xdescribe 'show_end_attendanceTime' do
    # TODO
    it 'has data' do
      expect(helper).to receive(:time_select)
      expect(helper.show_start_attendanceTime(attendance_time, Date.today)).to eq ''
    end

    it 'not data' do
      expect(helper).to receive(:time_select)
    end
  end

  describe 'default_start_hour' do
    it 'is weekday' do
      expect(helper).to receive(:weekend?).with(date).and_return(false)
      expect(helper.default_start_hour(date)).to eq '10'
    end

    it 'is holiday' do
      expect(helper).to receive(:weekend?).with(date).and_return(true)
      expect(helper.default_start_hour(date)).to eq '00'
    end
  end

  describe 'default_end_hour' do
    it 'is weekday' do
      expect(helper).to receive(:weekend?).with(date).and_return(false)
      expect(helper.default_end_hour(date)).to eq '19'
    end

    it 'is holiday' do
      expect(helper).to receive(:weekend?).with(date).and_return(true)
      expect(helper.default_end_hour(date)).to eq '00'
    end
  end

  describe 'selected_status' do
    it 'has data' do
      expect(helper.selected_status(attendance_time, date)).to eq 'work'
    end

    it 'no data and holiday' do
      expect(helper).to receive(:weekend?).with(date).and_return(true)
      expect(helper.selected_status(nil, date)).to eq ['休日', :holiday]
    end

    it 'no data and weekday' do
      expect(helper).to receive(:weekend?).with(date).and_return(false)
      expect(helper.selected_status(nil, date)).to eq ['出勤', :work]
    end
  end

  describe 'weekend?' do
    it 'is saturday' do
      expect(helper.weekend?(Date.new(2018, 4, 28))).to eq true
    end
    it 'is sunday' do
      expect(helper.weekend?(Date.new(2018, 5, 6))).to eq true
    end
    it 'is holiday' do
      expect(helper.weekend?(Date.new(2018, 5, 4))).to eq true
    end
    it 'is weekday' do
      expect(helper.weekend?(Date.new(2018, 5, 2))).to eq false
    end
  end

  describe 'holiday?' do
    it 'is holiday' do
      expect(helper.holiday?(Date.new(2018, 5, 4))).to eq true
    end
    it 'is weekday' do
      expect(helper.holiday?(Date.new(2018, 5, 2))).to eq false
    end
  end

  describe 'change_date' do
    it 'normal process' do
      expect(helper.change_date(date, 5)).to eq Date.new(2018, 5, 5)
    end
  end

  describe 'is_include?' do
    let(:days) { [Date.yesterday, Date.today, Date.tomorrow] }
    it 'normal process' do
      expect(helper.is_include?(days, Date.today)).not_to eq nil
    end

    it 'no data' do
      expect(helper.is_include?(days, date)).to eq nil
    end
  end
end
