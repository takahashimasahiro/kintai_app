class OperationLogController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count
  before_action :set_paper_trail_whodunnit

  def index
    @all_user = User.all
    @vacation_logs = PaperTrail::Version.where(item_type: 'ApplyVacation').order(:id)
    @all_vacations = ApplyVacation.all
    @user_id_name = User.select(:id, :name)
  end
end
