require 'sinatra'
require 'active_support/core_ext'
require 'exception_notification'

set :environment, :production
set :server, :puma
disable :run
 
require File.join(File.dirname(__FILE__), 'hiphooks')
run SinatraApp