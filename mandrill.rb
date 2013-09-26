require_relative 'hipchat'
require 'json'

class Mandrill
  def self.process(events, color)
    JSON.parse(events).each do |event|
      msg = event['msg']
      next if msg['email'].index("@payaus.com").present? # don't track if we open it
      next if msg['tags'].empty? # only display tagged emails
      next if msg['opens'].length > 1 # don't repeatedly show an email

      message = "Email #{color == HipChat::Colors::EMAIL_OPEN ? 'opened' : 'clicked'} by #{msg['email']}. Subject: #{msg['subject']}."
      unless msg['url'].nil?
        message = "#{message} URL: #{msg['url']}"
      end
      HipChat::Rooms.message(message, HipChat::Rooms::EMAILS, color)
    end
  end
end