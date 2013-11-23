require 'json'

module MtGoxWebsocket
  module API
    def subscribe(channel)
      payload = {
        channel: channel,
        op:      'mtgox.subscribe'
      }
      
      @conn.send(payload.to_json)
    end
    
    def unsubscribe(channel)
      payload = {
        channel: channel,
        op:      'unsubscribe'
      }
      
      @conn.send(payload.to_json)        
    end
  end 
end