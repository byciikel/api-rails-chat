class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'chat_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def history
    chats = Chat.all.collect(&:message)
    data = { message: chats, type: 'history' }
    ActionCable.server.broadcast('chat_channel', data)
  end

  def create(message)
    result = Chat.create(message: message.fetch('message'))
    if result.save
      data = { message: result, type: 'create' }
      ActionCable.server.broadcast('chat_channel', data)
    else
      log.debug result.errors.full_messages
    end
  end
end
