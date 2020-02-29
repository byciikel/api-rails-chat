class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'chat_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def history
    id = Chat.all.collect(&:id)
    chats = Chat.all.collect(&:message)
    created_at = Chat.all.collect(&:create_at)

    messages = { id: id, created_at: created_at, message: messages }

    data = { message: messages, type: 'history' }
    ActionCable.server.broadcast('chat_channel', data)
  end

  def create(message)
    result = Chat.create(message: message.fetch('message'))
    data = { message: result, type: 'create' }
    ActionCable.server.broadcast('chat_channel', data)
  end
end
