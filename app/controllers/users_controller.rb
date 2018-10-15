class UsersController < ApplicationController
  before_action :authenticate_current_user

  def home
    @dateofweek = ["日","月","火","水","木","金","土"]
    @today = Date.today
    @show_years = []
    (@today.year.to_i - 10..@today.year.to_i + 10).map{|i| @show_years << i}
    @lastday = @today.end_of_month.day
  end

  def show
    @today = params[:select_year]
    @dateofweek = ["日","月","火","水","木","金","土"]
    @show_years = []
    (@today.year.to_i - 10..@today.year.to_i + 10).map{|i| @show_years << i}
    render('users/home')
  end

  def save
    # テーブルに登録する処理
    render('users/home')
  end
end
