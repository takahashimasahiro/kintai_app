require 'rails_helper'

RSpec.describe AttendanceToCsvController, type: :controller do
  let(:user){ FactoryBot.create :user}

  before do
    session[:id] = 1
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
end
