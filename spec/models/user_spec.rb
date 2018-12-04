require 'rails_helper'

RSpec.describe User, type: :model do
  let(:owner_user) { User.find_by(role: :owner) }
  let(:employee_user) { User.find_by(role: :employee) }
  before do
    FactoryBot.create :user
    FactoryBot.create :user, :employee
  end

  describe "it's owner" do
    it 'Get Data YourSelf' do
      expect(User.select_user(1, owner_user)).to eq owner_user
    end

    it 'Get Select User Data' do
      expect(User.select_user(2, owner_user)).to eq employee_user
    end
  end

  describe 'not owner' do
    it 'Get Data YourSelf' do
      expect(User.select_user(2, employee_user)).to eq employee_user
    end

    it "can't get it except yourself " do
      expect(User.select_user(1, employee_user)).to eq employee_user
    end
  end
end
