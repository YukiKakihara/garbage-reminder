require 'date'
require 'net/http'
require 'uri'

def lambda_handler(_event:, _context:)
  day = Date.today.wday
  msg = message(day)
  res = post_message_to_line(msg)

  { statusCode: res.code, body: res.body }
end

def message(day)
  case day
  when 2, 6
    '今日は「燃えるゴミ」の収集日です'
  when 3
    '今日は「缶・ビン・ペットボトル」の収集日です'
  when 5
    '今日は「プラスチックごみ」の収集日です'
  else
    '今日はゴミの収集日ではありません'
  end
end

def post_message_to_line(msg)
  uri          = URI.parse('https://api.line.me/v2/bot/message/broadcast')
  http         = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = uri.scheme == 'https'

  params  = { 'messages': [{ 'type': 'text', 'text': msg.to_s }] }
  headers = { 'Content-Type': 'application/json', 'Authorization': "Bearer {#{ENV['LINE_CHANNEL_ACCESS_TOKEN']}}" }

  http.post(uri.path, params.to_json, headers)
end
