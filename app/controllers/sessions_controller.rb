# LoginFormsController
class SessionsController < ApplicationController
  before_action :forbid_current_user, only: %i[login new]
  before_action :authenticate_current_user, only: %i[destroy]

  def new
    @user = User.new
    session[:id] = nil
    @current_user = nil
    @error_message = nil
  end

  def index
    @user = User.find_by(email: params[:user][:email])
    if @user&.authenticate(params[:user][:password])
      session[:id] = @user.id
      redirect_to attendance_path(@user.id), flash: { notice: I18n.t('messages.login_success') }
    else
      @error_message = I18n.t('messages.login_failed')
      render :new
    end
  rescue StandardError => e
    @error_message = e.message
    render :new
  end

  def destroy
    session[:id] = nil
    @current_user = nil
    @error_message = nil
    redirect_to '/'
  end
end
