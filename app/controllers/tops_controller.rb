class TopsController < ApplicationController
  def top
  end

  def new
    
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.user_id
      flash[:notice] ="ログインしました"
      redirect_to("/users/home")
    else
      @error_message = "アドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("tops/top")
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to("/")
  end
end
