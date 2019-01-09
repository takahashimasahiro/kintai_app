require 'rails_helper'

RSpec.describe OperationLogController, type: :controller do
  let(:user) { FactoryBot.create :user }

  before do
    session[:id] = '1'
    expect(User).to receive(:find).with(session[:id]).and_return(user)
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
