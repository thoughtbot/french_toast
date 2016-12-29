module FrenchToast
  class Notifier
    def initialize(session_key)
      @session_key = session_key
    end

    def notify(payload)
      notify_by_action_cable(payload)
    end

    private

    attr_reader :session_key

    def notify_by_action_cable(payload)
      ActionCable.server.broadcast(session_key, "Your article has been processed.")
    end
  end
end
