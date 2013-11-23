require 'faye/websocket'
require 'hashie'

require './lib/mtgox_websocket/api.rb'

module MtGoxWebsocket
  class Client
    include API
    
    @@default_origin = 'http://example.com'
    @@event_types = [:open, :close, :subscribe, :unsubscribe, :private, :remark, :error]
    
    def initialize(args={})
      @args = args
      @event_listeners = {}
      @@event_types.each { |et| @event_listeners[et] = [] }
    end
    
    def connect
      @conn = ::Faye::WebSocket::Client.new('ws://websocket.mtgox.com:80/mtgox', nil, { 
        headers: {'Origin' => @args[:headers] && @args[:headers][:origin]  || @@default_origin}
      })
            
      @conn.on(:open) { dispatch_event(:open) }
      @conn.on(:close) { dispatch_event(:close) }
      @conn.on(:error) { dispatch_event(:error) }
      @conn.on(:message) do |event|
        data = ::Hashie::Mash.new(JSON.parse(event.data))
        
        dispatch_event(data.op.to_sym, data)
      end
    end 
    
    def self.connect(args={})
      client = new(args)
      client.connect
      client
    end
    
    def on(event_type, &block)
      add_event_listener(event_type, &block)
    end
    
    private
    
    def add_event_listener(event_type, &block)
      @event_listeners[event_type] << block
    end
    
    def dispatch_event(event_type, data=nil)
      @event_listeners[event_type].each do |block|
        block.call(data)
      end
    end
  end
end
