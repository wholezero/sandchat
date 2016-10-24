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
