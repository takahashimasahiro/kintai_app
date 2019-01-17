class SlackBot
  def initialize
    @api_key = Rails.application.credentials.slack[:token_key]
    @channel = '#kintai_bot_test'
    @name = 'kintaibot'
    Slack.configure do |config|
      config.token = @api_key
    end
    Slack.realtime
  end

  def post(message)
    Slack.chat_postMessage(text: message, username: @name, channel: @channel)
  end
end
