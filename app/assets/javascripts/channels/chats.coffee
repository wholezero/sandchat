###
SandChat - Sandstorm chat server

Copyright 2016 Steven Dee i@wholezero.org

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
###
jQuery(document).on 'turbolinks:load', ->
  chats = $('#chats')
  chats_to_bottom = -> chats.scrollTop(chats.prop('scrollHeight'))
  chats_to_bottom()

  App.global_chat = App.cable.subscriptions.create "ChatsChannel",
    connected: ->

    disconnected: ->

    received: (data) ->
      chats.append data['chat']
      chats_to_bottom()

    send_chat: (chat) ->
      @perform 'send_chat', chat: chat

  $('#new_chat').submit (e) ->
    $this = $(this)
    textarea = $this.find('#chat_message')
    if $.trim(textarea.val()).length > 1
      App.global_chat.send_chat textarea.val()
      textarea.val('')
    e.preventDefault()
    return false
