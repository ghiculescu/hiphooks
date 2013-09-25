require 'sinatra'
configure { set :server, :puma }

require_relative 'hipchat'
require_relative 'mandrill'

# from mandrill: an email was opened
post '/mail/open' do
  Mandrill.process(params['mandrill_events'], HipChat::Colors::EMAIL_OPEN)
  status 200
end

# from mandrill: an email link was clicked
post '/mail/click' do
  Mandrill.process(params['mandrill_events'], HipChat::Colors::EMAIL_CLICK)
  status 200
end