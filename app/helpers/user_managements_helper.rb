module UserManagementsHelper
  module ManagementsConstant
    ROLE = [['管理者','owner'],['社員','employee'],['アルバイト','part_time_job']].map(&:freeze).freeze
  end
  def all_role
    ManagementsConstant.freeze
    ManagementsConstant::ROLE
  end
end
