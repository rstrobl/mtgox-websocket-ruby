require 'rubygems'
require 'bundler/setup'
require 'eventmachine'
require 'mtgox/websocket'

EM.run do
  mtgox = MtGox::Websocket::Client.connect
  
  mtgox.on(:open) do
    puts "Connection opened"
    
    # Unsubscribe ticker
    mtgox.unsubscribe('d5f06780-30a8-4a48-a2f8-7ed181b4a13f')
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