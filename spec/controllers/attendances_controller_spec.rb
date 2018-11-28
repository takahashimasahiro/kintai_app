# TODO: specを全面的に見直す

require 'rails_helper'

RSpec.describe AttendancesController, type: :controller do
  include ApplicationHelperSpec

  let(:user) do
    User.create(
      id: 1,
      email: 'test@example.com',
      name: 'testuser',
      role: 'owner',
      password: 'password'
    )
  end
  session = { 'id' => 1 }

  before do
    user
    add_session(session)
  end

  describe 'GET #show' do
    let(:id) { user.id }
    it 'returns http success' do
      get :show, params: { id: id }
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe 'PATCH #update' do
    let(:id) { user.id }
    it 'returns http success' do
      params = {
        id: id,
        change_rows: '1',
        "status#{user.id}": 'work',
        "work_#{user.id}": {
          "start(1i)": '2018',
          "start(2i)": '11',
          "start(3i)": '1',
          "start(4i)": '10',
          "start(5i)": '0',
          "end(1i)": '2018',
          "end(2i)": '11',
          "end(3i)": '1',
          "end(4i)": '19',
          "end(5i)": '0'
        }
      }
      patch :update, params: params, as: :json
      expect(response).to have_http_status '302'
    end
  end
end
