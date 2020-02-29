class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def history
    messages = ChatChannel.all.collect(&:message)
    data = { message: messages, type: 'history' }
    ActionCable.server.broadcast('chat_channel', data)
  end

  def create(message)
    result = ChatChannel.create(message: message.fetch('message'))
    data = { message: result, type: 'create' }
    ActionCable.server.broadcast('chat_channel', data)
  end
end
