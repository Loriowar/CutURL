# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application

# Rake-task server interface
#require 'resque/server'
#run Rack::URLMap.new "/" => Rails.application.class,  "/resque" => Resque::Server.new
