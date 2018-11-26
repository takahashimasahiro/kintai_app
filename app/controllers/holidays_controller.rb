# frozen_string_literal: true

class HolidaysController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count

  def show
    @my_vacations = @current_user.apply_vacations.all.order(:get_start_date)
  end

  def edit
    # 有休申請者一覧を表示
    # ユーザー名はUserに入れているためjoinする
    @applying_vacation = User.joins(:apply_vacations)
                             .where(apply_vacations: {status: :applying})
                             .select('apply_vacations.* , users.name ')
  end

  def update
    @vacation_data = ApplyVacation.find_by(applicant_id: params[:user_id], get_start_date: params[:get_date])
    if @vacation_data
      @vacation_data.status = params[:button]
      if params[:approve]
        # 許可
        @vacation_data.reduce_holiday_count
      elsif params[:dismiss]
        # 却下
        @vacation_data.change_attend_status
      end
      @vacation_data.save!
    end
    redirect_to edit_holiday_path(@current_user.id), flash: { notice: '保存しました' }
  end
end
