require 'rails_helper'

RSpec.describe UsersHelper, type: :module do
  let(:test_class) { Struct.new(:attendances_helper) { include UsersHelper } }
  let(:helper) { test_class.new }

  describe 'user_select_status' do
    it 'normal process' do
      expect(helper.user_select_status(:work)).to eq '出勤'
    end

    it 'no data' do
      expect(helper.user_select_status(nil)).to eq '未定'
    end
  end
end
