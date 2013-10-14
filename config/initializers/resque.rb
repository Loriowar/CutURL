# Resque configuration

uri = URI.parse("redis://localhost:6379/")
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

#Add all tasks in queue
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }