require 'rails_helper'

RSpec.describe AttendancesHelper, type: :module do
  let(:test_class) { Struct.new(:attendances_helper) { include AttendancesHelper } }
  let(:helper) { test_class.new }
  let(:work_date) { Date.new(2018, 5, 2) } # 水曜日,平日
  let(:holiday_date) { Date.new(2018, 5, 4) } # 金曜日,祝日
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
    let(:select_status) { ['出勤', :work] }
    context 'not work' do
      it 'is holiday' do
        expect(helper).to receive(:holiday?).with(work_date).and_return(true)
        expect(helper.create_day_of_week_classname(work_date, select_status, nil)).to eq 'holiday'
      end

      context 'paid_holiday' do
        it 'approved' do
          select_status = ['有給休暇', :vacation]
          expect(helper).to receive(:holiday?).with(work_date).and_return(false)
          expect(helper.create_day_of_week_classname(work_date, select_status, [[work_date]])).to eq 'approved'
        end

        it 'not_approved' do
          select_status = ['有給休暇', :vacation]
          expect(helper).to receive(:holiday?).with(work_date).and_return(false)
          expect(helper.create_day_of_week_classname(work_date, select_status, [[holiday_date]])).to eq 'not_approved'
        end
      end
    end

    it 'work date' do
      expect(helper).to receive(:holiday?).with(work_date).and_return(false)
      expect(helper.create_day_of_week_classname(work_date, select_status, nil)).to eq work_date.wday.to_s
    end
  end

  describe 'show_years_map' do
    it 'normal process' do
      years = (2008..2028).map { |x| x }
      expect(helper.show_years_map(work_date)).to eq years
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

  describe 'show_start_attendanceTime' do
    it 'has data' do
      ans_hash = helper.show_start_attendanceTime(attendance_time, Date.today)
      expect(ans_hash[:year]).to eq attendance_time.work_date.year
      expect(ans_hash[:month]).to eq attendance_time.work_date.month
      expect(ans_hash[:day]).to eq Date.today.day
      expect(ans_hash[:hour]).to eq attendance_time.work_start.hour
      expect(ans_hash[:minute]).to eq attendance_time.work_start.min
    end

    it 'no data' do
      ans_hash = helper.show_start_attendanceTime(nil, Date.today)
      expect(ans_hash[:year]).to eq Date.today.year
      expect(ans_hash[:month]).to eq Date.today.month
      expect(ans_hash[:day]).to eq Date.today.day
      expect(ans_hash[:hour]).to eq 0
      expect(ans_hash[:minute]).to eq 0
    end
  end

  describe 'show_end_attendanceTime' do
    it 'has data' do
      ans_hash = helper.show_end_attendanceTime(attendance_time, Date.today)
      expect(ans_hash[:year]).to eq attendance_time.work_date.year
      expect(ans_hash[:month]).to eq attendance_time.work_date.month
      expect(ans_hash[:day]).to eq Date.today.day
      expect(ans_hash[:hour]).to eq attendance_time.work_end.hour
      expect(ans_hash[:minute]).to eq attendance_time.work_end.min
    end

    it 'not data' do
      ans_hash = helper.show_end_attendanceTime(nil, Date.today)
      expect(ans_hash[:year]).to eq Date.today.year
      expect(ans_hash[:month]).to eq Date.today.month
      expect(ans_hash[:day]).to eq Date.today.day
      expect(ans_hash[:hour]).to eq 0
      expect(ans_hash[:minute]).to eq 0
    end
  end

  describe 'default_start_hour' do
    it 'is weekday' do
      expect(helper).to receive(:weekend?).with(work_date).and_return(false)
      expect(helper.default_start_hour(work_date)).to eq 0
    end

    it 'is holiday' do
      expect(helper).to receive(:weekend?).with(work_date).and_return(true)
      expect(helper.default_start_hour(work_date)).to eq 0
    end
  end

  describe 'default_end_hour' do
    it 'is weekday' do
      expect(helper).to receive(:weekend?).with(work_date).and_return(false)
      expect(helper.default_end_hour(work_date)).to eq 0
    end

    it 'is holiday' do
      expect(helper).to receive(:weekend?).with(work_date).and_return(true)
      expect(helper.default_end_hour(work_date)).to eq 0
    end
  end

  describe 'selected_status' do
    it 'has data' do
      expect(helper.selected_status(attendance_time, work_date)).to eq ['出勤', :work]
    end

    it 'no data and holiday' do
      expect(helper).to receive(:weekend?).with(work_date).and_return(true)
      expect(helper.selected_status(nil, work_date)).to eq ['休日', :holiday]
    end

    it 'no data and weekday' do
      expect(helper).to receive(:weekend?).with(work_date).and_return(false)
      expect(helper.selected_status(nil, work_date)).to eq ['出勤', :work]
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
      expect(helper.weekend?(holiday_date)).to eq true
    end
    it 'is weekday' do
      expect(helper.weekend?(work_date)).to eq false
    end
  end

  describe 'holiday?' do
    it 'is holiday' do
      expect(helper.holiday?(holiday_date)).to eq true
    end
    it 'is weekday' do
      expect(helper.holiday?(work_date)).to eq false
    end
  end

  describe 'change_date' do
    it 'normal process' do
      expect(helper.change_date(work_date, 5)).to eq Date.new(2018, 5, 5)
    end
  end

  describe 'is_include?' do
    let(:days) { [[Date.yesterday, 0.5], [Date.today, 1], [Date.tomorrow, 0.5]] }
    it 'normal process' do
      expect(helper.is_include?(days, Date.today)).not_to eq nil
    end

    it 'no data' do
      expect(helper.is_include?(days, work_date)).to eq nil
    end
  end

  describe 'calculate_working_time' do
    it 'normal process' do
      expect(helper.calculate_working_time(attendance_time, Date.today)).to eq 480
    end
    it 'is no data and holiday' do
      expect(helper.calculate_working_time(nil, holiday_date)).to eq 0
    end
    it 'is no data and not holiday' do
      ret_value = ((AttendancesHelper::DEFAULT_WORK_END - AttendancesHelper::DEFAULT_WORK_START) * 60)
      expect(helper.calculate_working_time(nil, Date.today)).to eq ret_value
    end
  end

  describe 'calculate_break_time' do
    it 'normal process' do
      expect(helper.calculate_break_time(attendance_time, Date.today)).to eq 60
    end
    it 'is holiday_work' do
      attendance_time.work_date = holiday_date
      attendance_time.status = :holiday_work
      expect(helper.calculate_break_time(attendance_time, holiday_date)).to eq 60
    end

    it 'is no data and holiday' do
      expect(helper.calculate_break_time(nil, holiday_date)).to eq 0
    end
    it 'is no data and work date' do
      expect(helper.calculate_break_time(nil, work_date)).to eq 0
    end
  end

  describe 'calculate_over_time' do
    it 'is over work for ten minutes ' do
      attendance_time.work_end = DateTime.now + Rational(9, 24) + Rational(10, 24 * 60)
      expect(helper.calculate_over_time(attendance_time)).to eq 10
    end

    it 'is no over work' do
      expect(helper.calculate_over_time(attendance_time)).to eq 0
    end

    it 'is no data' do
      expect(helper.calculate_over_time(nil)).to eq 0
    end
  end

  describe 'convert_min' do
    it 'is zero minutes' do
      expect(helper.convert_min(0)).to eq '0分'
    end
    it 'is one hours' do
      expect(helper.convert_min(60)).to eq '1時間'
    end
    it 'is eight hours and nen minutes' do
      min = (8 * 60) + 10
      expect(helper.convert_min(min)).to eq '8時間10分'
    end
  end

  describe 'month_holiday_count' do
    it 'calculate holiday 2018/5' do
      expect(helper.month_holiday_count(work_date.change(day: 1))).to eq 10
    end
  end
end
