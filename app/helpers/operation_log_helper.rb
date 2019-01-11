module OperationLogHelper
  include HolidaysHelper
  include UserManagementsHelper

  # ログの文字列をhash化する
  def log_convert_hash(item)
    return nil if item.object.nil?

    if item.item_type == 'ApplyVacation'
      hash = item.object.delete(' ').split(/[:\n]/)
      hash.delete('---')
      hash.each_slice(2).map { |k, v| [k.to_sym, v] }.to_h
    elsif item.item_type == 'User'
      hash = item.object.delete(' ').split(/[:\n]/)
      hash.delete('---')
      hash.each_slice(2).map { |k, v| [k.to_sym, v] }.to_h
    end
  end
end
