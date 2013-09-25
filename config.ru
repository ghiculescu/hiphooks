require 'sinatra'

set :environment, :production
set :server, :puma
disable :run
 
require File.join(File.dirname(__FILE__), 'hiphooks')
run Sinatra::Application