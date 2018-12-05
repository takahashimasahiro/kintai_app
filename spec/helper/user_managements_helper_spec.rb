require 'rails_helper'

RSpec.describe UserManagementsHelper, type: :module do
  let(:test_class) { Struct.new(:attendances_helper) { include UserManagementsHelper } }
  let(:helper) { test_class.new }

  describe 'all_role' do
    it 'normal process' do
      expect(helper.all_role[:owner]).to eq '管理者'
    end
  end
end
