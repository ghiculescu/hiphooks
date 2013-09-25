require 'hipchat'
require_relative 'config'

module HipChat
  class Colors
    EMAIL_OPEN = 'yellow'
    EMAIL_CLICK = 'green'
  end

  class Rooms
    EMAILS = "Emails"

    def self.message(text, room, color)
      hipchat_auth_token = ENV['HIPCHAT_AUTH_TOKEN']
      if hipchat_auth_token
        hipchat = HipChat::Client.new(hipchat_auth_token)
        room = hipchat[room]
        room.send('Alert', text, color: color)
      end
    end
  end
end