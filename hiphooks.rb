require_relative 'hipchat'
require_relative 'mandrill'

class SinatraApp < Sinatra::Base
  use ExceptionNotification::Rack,
    :email => {
      :email_prefix => "[HipHooks Exception] ",
      :sender_address => %{"HipHooks Exception notifier" <info@payaus.com>},
      :exception_recipients => %w{support@payaus.com},
      :normalize_subject => true,
      :smtp_settings => {
        :address        => 'smtp.mandrillapp.com',
        :port           => '587',
        :authentication => :plain,
        :user_name      => ENV['MANDRILL_USERNAME'],
        :password       => ENV['MANDRILL_APIKEY'],
        :enable_starttls_auto => true,
        :domain         => 'payaus.com'
      }
    } 

  get '/' do
    raise Exception.new("test")
  end

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
end