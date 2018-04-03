require 'fluent-logger'
Fluent::Logger::FluentLogger.open(nil, :host=>'localhost', :port=>24224)
Fluent::Logger.post("docker.test", {"from"=>"userA", "to"=>"userB"})