require 'eventmachine'
require './lib/mtgox_websocket.rb'

EM.run do
  mtgox = MtGoxWebsocket::Client.connect
  
  mtgox.on(:open) do
    puts "Connection opened"
  end
  
  mtgox.on(:close) do
    puts "Connection closed"
  end

  mtgox.on(:error) do
    puts "Error"
  end
  
  mtgox.on(:subscribe) do |data|
    puts "Subscribe: #{data.channel}"    
  end

  mtgox.on(:unsubscribe) do |data|
    puts "Unsubscribe: #{data.channel}"    
  end
  
  mtgox.on(:remark) do |data|
    puts "Remark: #{data.message}"
  end
  
  mtgox.on(:private) do |data|
    puts "#{data.channel_name}[#{data.channel}]: #{data.private}"
  end
end