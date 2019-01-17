class SlackJob
  include SuckerPunch::Job

  def initialize
    @api_key = Rails.application.credentials.slack[:token_key]
    @channel = '#kintai_bot_test'
    @name = 'kintaibot'
    Slack.configure do |config|
      config.token = @api_key
    end
    # TODO: 処理の分割
    # bot = SlackBot.new
    client = Slack.realtime

    client.on :hello do
      # bot初回連携時処理
    end

    client.on :message do |data|
      return nil unless data

      p data
      # ループ回避
      unless data['bot_id']
        # TODO: バリデーションチェック
        # TODO:API連携
        # TODO:正規表現はどこかでまとめて、見やすくする
        if /(モ[ー〜]+ニン|も[ー〜]+にん|おっは|おは|へろ|はろ|ヘロ|ハロ|hi|hello|morning|出勤)/.match?(data['text'])
          post("<@#{data['user']}> おはようございます。(#{DateTime.now.strftime('%Y/%m/%d %H:%M')})")
        elsif /(バ[ー〜ァ]*イ|ば[ー〜ぁ]*い|おやすみ|お[つっ]ー|おつ|さらば|お先|お疲|帰|乙|bye|night|(c|see)\s*(u|you)|退勤|ごきげんよ|グ[ッ]?バイ)/.match?(data['text'])
          post("<@#{data['user']}> お疲れ様でした。(#{DateTime.now.strftime('%Y/%m/%d %H:%M')})")
        elsif /(休|やす(ま|み|む)|休暇)/.match?(data['text'])
          post("<@#{data['user']}> #{DateTime.now.strftime('%Y/%m/%d %H:%M')}を休暇として登録しました")
        end
      end
    end

    # bot終了時処理
    client.on :close do
      # post('goodbye')
    end
    client.start
  end

  private

  def post(message)
    Slack.chat_postMessage(
      text: message,
      username: @name,
      channel: @channel
    )
  end
end
