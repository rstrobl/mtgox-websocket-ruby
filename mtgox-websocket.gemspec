Gem::Specification.new do |s|
  s.name        = 'mtgox-websocket'
  s.version     = '0.0.1'
  s.date        = '2013-11-23'
  s.summary     = "Eventmachine-based library for building real-time ruby applications using the Mt.Gox websocket API"
  s.authors     = ["Robert Strobl"]
  s.email       = 'mail@rstrobl.com'
  s.homepage    = 'https://github.com/rstrobl/mtgox-websocket-ruby'
  s.license     = 'MIT'
  s.files       = Dir.glob('lib/**/*.rb')
  
  s.add_dependency 'eventmachine', '>= 0.12.0'
  s.add_dependency 'faye-websocket', '>= 0.7.0'
  s.add_dependency 'hashie', '>= 2.0.5'
  s.add_dependency 'json', '>= 1.8.1'
end