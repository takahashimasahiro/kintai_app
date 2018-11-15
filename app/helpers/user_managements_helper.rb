# frozen_string_literal: true

module UserManagementsHelper
  module ManagementsConstant
    ROLE = [%w[管理者 owner], %w[社員 employee], %w[アルバイト part_time_job]].map(&:freeze).freeze
  end
  def all_role
    ManagementsConstant.freeze
    ManagementsConstant::ROLE
  end

  def select_role(role)
    ManagementsConstant.freeze
    show_role = nil
    ManagementsConstant::ROLE.each do |x|
      show_role = x[0] if x[1] == role
    end
    show_role
  end
end
