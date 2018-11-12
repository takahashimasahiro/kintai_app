class UsersController < ApplicationController
  before_action :forbid_current_user, {only: [:new, :create]}
  before_action :authenticate_current_user, {only: [:edit, :update, :index]}
  before_action :apply_count, {only: [:edit, :update, :index]}

  def index
    # ユーザー一覧を表示する
    @state_of_all_user = User.joins(
      "LEFT OUTER JOIN attendance_times ON 
      users.id = attendance_times.user_id 
      and attendance_times.work_date = '#{Date.today}'"
      ).select(
        'users.*, attendance_times.*'
      )
  end

  def new
    @user = User.new
    session[:id] = nil
    @current_user = nil
    @error_messages = nil
  end
  
  def create
    @user = User.new(user_params)
    # テスト用
    @user.name = "テストユーザー"
    @user.role = 'owner'
    if @user.save
      session[:id] = @user.id
      redirect_to attendance_path(@user.id), flash: {notise: 'ログインしました'}
    else
      @email = params[:email]
      @password = params[:password]
      render 'new'
    end
  end

  def edit
    @user = @current_user
  end

  def update 
    @user = @current_user
    if params[:user]['new_password1'] == params[:user]['new_password2'] && @user.authenticate(params[:user]['old_password'])
        @user.name = params[:page]['name']
        @user.password = params[:user]['new_password1']
        if @user.save
          redirect_to edit_user_path(@current_user.id) ,flash: {notice: '保存しました'}
        else
          render 'edit'
        end
    else
      @error_messages = 'パスワードが異なっています'
      render 'edit'
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:email, :password, :name)
    end
    
end
