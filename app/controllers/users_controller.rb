class UsersController < ApplicationController
  before_action :forbid_current_user, only: %i[new create]
  before_action :authenticate_current_user, only: %i[edit update index]
  before_action :apply_count, only: %i[edit update index]

  def index
    # ユーザー名と本日の出勤状況を取得する
    # AttendanceTimeのstatusが取得できない場合は
    # ユーザー名だけ取得
    @state_of_all_user = User.joins(
      "LEFT OUTER JOIN attendance_times ON
      users.id = attendance_times.user_id
      and attendance_times.work_date = '#{Date.today}'"
    ).select(
      'users.name,
      attendance_times.status,
      attendance_times.updated_at'
    )
    
    # User.left_joins(:attendance_times)
    # .where(attendance_times: {work_date: "#{Date.today}"})
    # .pluck(users: [:name], attenadance_times: [:status, :update_at])
  end

  def new
    @user = User.new
    session[:id] = nil
    @current_user = nil
    @error_message = nil
  end

  def create
    @user = User.new(user_params)
    @user.role = :employee
    if @user.save
      session[:id] = @user.id
      redirect_to attendance_path(@user.id), flash: { notise: 'ログインしました' }
    else
      render :new
    end
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user
    if params[:user][:new_password1] ==
        params[:user][:new_password2] &&
        @user.authenticate(params[:user][:old_password])

      @user.name = params[:page][:name]
      @user.password = params[:user][:new_password1]
      if @user.save
        redirect_to edit_user_path(@current_user.id), flash: { notice: '保存しました' }
      else
        render :edit
      end
    else
      @error_message = 'パスワードが異なっています'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end
