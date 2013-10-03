require_relative 'hipchat'
require 'json'

class Mandrill
  def self.process(events, color)
    JSON.parse(events).each do |event|
      puts event
      msg = event['msg']
      puts msg
      next if msg['email'].nil? || msg['subject'].nil?
      next unless msg['email'].index("@payaus.com").nil? # don't track if we open it
      next if msg['tags'].empty? # only display tagged emails

      message = "Email #{color == HipChat::Colors::EMAIL_OPEN ? 'opened' : 'clicked'} by #{msg['email']}. Subject: #{msg['subject']}."
      unless event['url'].nil?
        message = "#{message} URL: #{event['url']}"
      end
      HipChat::Rooms.message(message, HipChat::Rooms::EMAILS, color)
    end
  end
end