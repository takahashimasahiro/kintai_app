class OperationLogController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count
  before_action :set_paper_trail_whodunnit

  def show; end
end
