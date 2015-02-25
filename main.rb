require 'net/http'
require 'json'

def beep
  3.times { `afplay /System/Library/Sounds/Ping.aiff` }
end

def update
  res = Net::HTTP.get URI('https://terminmanagement.regioit-aachen.de/aachen/mobile_bahnhofplatz/get.php?option=values')
  res.scan(/{.*?}/).collect { |r| JSON.parse r}.last.values.first
end

def alarm(number)
  loop do
    sleep 2
    if update.scan(/\d+/).first.to_i >= number
      beep
      return
    end
  end
end