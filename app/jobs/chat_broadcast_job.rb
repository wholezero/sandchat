class ChatBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat)
    puts "Performing broadcast for #{chat}"
    ActionCable.server.broadcast "chats_channel", chat: render_chat(chat)
  end

  private

  def render_chat(chat)
    puts "Rendering #{chat}"
    ChatsController.render partial: 'chats/chat', locals: {chat: chat}
  end
end
