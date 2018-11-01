class UserManagementsController < ApplicationController
  
  def index
    @all_user = User.all.order(:id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      email: params[:page]['email'],
      name: params[:page]['name'],
      role: params[:role],
      paid_holiday_count: params[:holiday_count],
      password: params[:page]['password'])
    if @user.save
      redirect_to user_managements_path, flash: {notice: '作成しました'}
    else
      render new_user_management_path
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.email = params[:page]['email']
    @user.name = params[:page]['name']
    @user.role = params[:role]
    @user.paid_holiday_count = params[:holiday_count]
    if params[:page]['password'].empty?
      @user.password = params[:page]['password']
    end

    if @user.save
      redirect_to user_managements_path, flash: {notice: '編集しました'}
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_managements_path, flash: {notice: '削除しました'}
  end
end
