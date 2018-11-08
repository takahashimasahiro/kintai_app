
module ApplicationHelperSpec
  def add_session(arg)
    arg.each { |k, v| session[k] = v }
  end
end

RSpec.configure do |config|
  config.include ApplicationHelperSpec, Type: :controller
end
