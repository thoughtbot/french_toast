module FrenchToast
  class Notifier
    def initialize(session_key)
      @session_key = session_key
    end

    def notify(partial_name, locals: {})
      processed_payload = process(partial_name, locals)
      store(processed_payload)
      notify_by_action_cable(processed_payload)
    end

    private

    attr_reader :session_key

    def process(partial_name, locals)
      ApplicationController.render(
        partial: "french_toast/#{partial_name}",
        locals: locals,
      )
    end

    def notify_by_action_cable(payload)
      ActionCable.server.broadcast(session_key, payload.html_safe)
    end

    def store(payload)
      LastNotification.find_or_create_by(
        session: session_key,
      ).tap do |notification|
        notification.update(data: payload)
      end
    end
  end
end
