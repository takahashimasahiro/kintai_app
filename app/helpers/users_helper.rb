# UsersHelper
module UsersHelper
  def show_years_map
    (@today.year.to_i - 10..@today.year.to_i + 10).map{|y| y}
  end
end
