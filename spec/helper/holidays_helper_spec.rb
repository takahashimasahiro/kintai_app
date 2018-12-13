require 'rails_helper'

RSpec.describe HolidaysHelper, type: :module do
  let(:test_class) { Struct.new(:attendances_helper) { include HolidaysHelper } }
  let(:helper) { test_class.new }

  describe 'application_status' do
    it 'normal process' do
      expect(helper.application_status[:applying]).to eq '申請中'
    end

    it 'no data' do
      expect(helper.application_status[nil]).to eq nil
    end
  end
end
