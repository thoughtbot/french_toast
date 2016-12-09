module FrenchToast
  class Notifier
    def initialize(session_key)
      @session_key = session_key
    end

    def notify(payload)
      ActionCable.server.broadcast(session_key, payload)
    end

    private

    attr_reader :session_key
  end
end
