require 'rails_helper'

RSpec.describe HolidaysHelper, type: :module do
  let(:test_class) { Struct.new(:attendances_helper) { include HolidaysHelper } }
  let(:helper) { test_class.new }

  describe 'application_status' do
    it 'normal process' do
      expect(helper.application_status[:applying]).to eq '申請中'
    end
  end
end
