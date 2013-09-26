require_relative 'hipchat'
require 'json'

class Mandrill
  def self.process(events, color)
    puts events
    JSON.parse(events).each do |event|
      msg = event['msg']
      message = "Email #{color == HipChat::Colors::EMAIL_OPEN ? 'opened' : 'clicked'} by #{msg['email']}. Subject: #{msg['subject']}."
      unless msg['url'].nil?
        message = "#{message} URL: #{msg['url']}"
      end
      HipChat::Rooms.message(message, HipChat::Rooms::EMAILS, color)
    end
  end
end