require 'resque/tasks'
require 'resque_scheduler/tasks'

task "resque:setup" => :environment

namespace :resque do
  task :setup do
    require 'resque'
    require 'resque_scheduler'
    require 'resque/scheduler'

    Resque.redis = 'localhost:6379'

    Resque.schedule = YAML.load_file("#{Rails.root}/config/rescue_schedule.yml")
  end
end

# Require runing redis-server
# For run task: rake resque:scheduler
# For observe current task: rake resque:work QUEUE=*