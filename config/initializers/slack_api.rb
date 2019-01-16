require 'slack'
require 'http'
require 'json'
require 'rails'
require 'eventmachine'
require 'faye/websocket'

response = HTTP.post(
  'https://slack.com/api/rtm.start',
  params: {
    token: Rails.application.credentials.slack[:token_key]
  }
)

# EM.run do
#   ws = Faye::WebSocket::Client.new(JSON.parse(response.body)['url'])
#   ws.on :open do
#   end

#   ws.on :message do |event|
#     event_data = JSON.parse(event.data)
#     if event_data['text'] == 'hi'
#       ws.send({
#         type: 'message',
#         text: "#{event_data['text']} , <@#{event_data['user']}>",
#         channel: event_data['channel']
#       }.to_json)
#     end
#   end

#   ws.on :close do |_event|
#     ws = nil
#     EM.stop
#   end
# end
