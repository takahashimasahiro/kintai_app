class UsersController < ApplicationController
  before_action :authenticate_current_user

  def home

  end

  def attendance
    @dateofweek = ["日","月","火","水","木","金","土"]
    @today = Date.today
    @first_year = []
    (@today.year.to_i - 10..@today.year.to_i + 10).each do |i|
      @first_year.push(i)
    end
    
    @lastday = @today.end_of_month.day
  end

  def attendande_table
    @today = params[:select_year]

    @dateofweek = ["日","月","火","水","木","金","土"]
    @first_year = []
    (@today.year.to_i - 10..@today.year.to_i + 10).each do |i|
      @first_year.push(i)
    end
  end

  def save

  end

end
