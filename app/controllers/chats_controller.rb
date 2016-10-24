class ChatsController < ApplicationController
  def index
    @title = "Hi"
    @chats = Chat.all
    @chat = Chat.new
  end
end
