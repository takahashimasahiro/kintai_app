class UserManagementsController < ApplicationController
  before_action :authenticate_current_user
  before_action :apply_count
  before_action :set_paper_trail_whodunnit

  def index
    @all_users = User.all.order(:id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      email: params[:page][:email],
      name: params[:page][:name],
      role: params[:role],
      paid_holiday_count: params[:holiday_count],
      password: params[:page][:password]
    )
    if @user.save
      redirect_to user_managements_path, flash: { notice: t(:create, scope: :messages) }
    else
      render new_user_management_path
    end
  end

  def edit
    @user = User.find(user_params)
  end

  def update
    @user = User.find(user_params)
    @user.email = params[:page][:email]
    @user.name = params[:page][:name]
    @user.role = params[:role]
    @user.paid_holiday_count = params[:holiday_count]

    unless params[:page][:password].empty?
      @user.password = params[:page][:password]
    end

    if @user.save
      redirect_to user_managements_path, flash: { notice: t(:edit, scope: :messages) }
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_managements_path, flash: { notice: t(:delete, scope: :messages) }
  end

  private

  def user_params
    params.require(:id)
  end
end
