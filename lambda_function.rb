require 'date'

def lambda_handler(event:, context:)
  day = Date.today.wday
  msg = message(day)
  { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end

def message(day)
  case day
  when 1, 5
    '今日は「燃えるゴミ」の収集日です'
  when 2
    '今日は「缶・ビン・ペットボトル」の収集日です'
  when 6
    '今日は「プラスチックごみ」の収集日です'
  else
    '今日はゴミの収集日ではありません'
  end
end
