class NotifierChannel < ApplicationCable::Channel
  def subscribed
    stream_from session_key
  end

  def unsubscribed
    stop_all_streams
  end
end
