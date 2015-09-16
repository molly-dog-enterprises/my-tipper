require 'rake'
require 'airbrake/rake_handler'

Airbrake.configure do |config|
  config.api_key = '88bbc6aa8baed00192c1e0a4f6773061'
  config.rescue_rake_exceptions = true
end
