class ChatsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chats_channel"
  end

  def unsubscribed
  end

  def send_chat(data)
    puts "send chat: #{data}"
    current_user.chats.create!(message: data['chat'])
  end
end
