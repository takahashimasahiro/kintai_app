module UserManagementsHelper
  module ManagementsConstant
    ROLE = [['管理者','owner'],['社員','employee'],['アルバイト','part_time_job']].map(&:freeze).freeze
  end
  def all_role
    ManagementsConstant.freeze
    ManagementsConstant::ROLE
  end

  def select_role(role)
    ManagementsConstant.freeze
    show_role = nil
    ManagementsConstant::ROLE.each do |x| 
      if x[1] == role
        show_role = x[0]
      end
    end
    show_role
  end
end
