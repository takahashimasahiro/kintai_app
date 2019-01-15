require 'slack'
# require 'slack-ruby-client'

# Slack.configure do |config|
#   config.token = Rails.application.credentials.slack[:token_key]
# end

# client = Slack::RealTime::Client.new

# #
# client.on :message do |data|
#   if data['text'].include?('test')
#     client.message channel: data['channel'], text: "response"
#   end
# end
