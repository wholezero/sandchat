#
# SandChat - Sandstorm chat server
#
# Copyright 2016 Steven Dee i@wholezero.org
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
class ChatBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat)
    ActionCable.server.broadcast "chats_channel", chat: render_chat(chat)
  end

  private

  def render_chat(chat)
    ChatsController.render partial: 'chats/chat', locals: {chat: chat}
  end
end
